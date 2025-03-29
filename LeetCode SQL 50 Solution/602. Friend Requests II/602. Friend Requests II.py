import pandas as pd

def most_friends(requests: pd.DataFrame) -> pd.DataFrame:
    # Create a DataFrame that contains all friend relationships in both directions
    friend_df = pd.concat([
        requests[['requester_id', 'accepter_id']].rename(columns={'requester_id': 'id', 'accepter_id': 'friend'}),
        requests[['accepter_id', 'requester_id']].rename(columns={'accepter_id': 'id', 'requester_id': 'friend'})
    ])
    
    # Count number of friends for each user
    friend_counts = friend_df.groupby('id').size().reset_index(name='num')
    
    # Get the user with the most friends
    max_friends = friend_counts.loc[friend_counts['num'].idxmax()]
    
    return pd.DataFrame({'id': [max_friends['id']], 'num': [max_friends['num']]})
