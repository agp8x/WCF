<?php
namespace wcf\data\user\follow;
use wcf\data\DatabaseObject;
use wcf\system\WCF;

/**
 * Represents a user's follower.
 * 
 * @author	Alexander Ebert
 * @copyright	2001-2015 WoltLab GmbH
 * @license	GNU Lesser General Public License <http://opensource.org/licenses/lgpl-license.php>
 * @package	com.woltlab.wcf
 * @subpackage	data.user.follow
 * @category	Community Framework
 *
 * @property-read	integer		$followID		unique id of the following relation
 * @property-read	integer		$userID			id of the following user
 * @property-read	integer		$followUserID		id of the followed user
 * @property-read	integer		$time			time at which following relation has been established
 */
class UserFollow extends DatabaseObject {
	/**
	 * @see	\wcf\data\DatabaseObject::$databaseTableName
	 */
	protected static $databaseTableName = 'user_follow';
	
	/**
	 * @see	\wcf\data\DatabaseObject::$databaseTableIndexName
	 */
	protected static $databaseTableIndexName = 'followID';
	
	/**
	 * Retrieves a follower.
	 * 
	 * @param	integer		$userID
	 * @param	integer		$followUserID
	 * @return	\wcf\data\user\follow\UserFollow
	 */
	public static function getFollow($userID, $followUserID) {
		$sql = "SELECT	followID
			FROM	wcf".WCF_N."_user_follow
			WHERE	userID = ?
				AND followUserID = ?";
		$statement = WCF::getDB()->prepareStatement($sql);
		$statement->execute(array(
			$userID,
			$followUserID
		));
		
		$row = $statement->fetchArray();
		if (!$row) $row = array();
		
		return new UserFollow(null, $row);
	}
}
