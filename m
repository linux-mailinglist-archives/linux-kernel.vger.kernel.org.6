Return-Path: <linux-kernel+bounces-549475-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A8D7A552FD
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 18:25:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CA6111890738
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 17:25:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72D0025D521;
	Thu,  6 Mar 2025 17:24:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hDzTqOOG"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E0C11DDA35
	for <linux-kernel@vger.kernel.org>; Thu,  6 Mar 2025 17:24:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741281878; cv=none; b=QaRTI3pOeEFPXYV7x7xQt6R4aRWZa2mT7p9TkMtTJYn+Rx6N/DnDsAelWn6lkDLgXtTiUMtwjbViJ5MH73vE3Pc01uEDgBpgeBEPTtTIayV7tbdXUOBndgJex/MfH0j+QFhealQbC1uPMAoyR3Ouao0RQKYymwz6B1078KMMh/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741281878; c=relaxed/simple;
	bh=DgTyAii1o40G5YSx8uLC9fMOK5tRyXwGyfapC4q2dPg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cJ4tsCQ2Kc8SI+67/wCvXG0Ekepwph+1+xyZ8oXdEb7ePZvKnftWYL4Jlgjtq71tlm68OVedoQhYGFAAhJUcJspsM8xhDqkdl79TIlExJyaKS+rA/w9UHNc2YOQeO79dJ+sqGVuj6A3sc5vB1HYrCZ1PV6lw5HwytKlV1yydIjg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hDzTqOOG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B58D7C4CEE0;
	Thu,  6 Mar 2025 17:24:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741281877;
	bh=DgTyAii1o40G5YSx8uLC9fMOK5tRyXwGyfapC4q2dPg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hDzTqOOGZd6gvgw/9TkX51caTJaGh2SmKrJt/5CO57To/bK9Mrco6/jnFTae8ZC1Y
	 69YO7wXWoAxnMwStVPAWc+3oe2KzDjr5vBywt8EmD+QLe0zQZ+/PSGcqZCrjLeqdvf
	 biZMvx0/19UBIimeLwAoEcJ4n0LvowvmrjJG0KcX9rvEaYJZOAtBXDv72bR877ZDRB
	 HwCGUDi+74K6A1r9aKOaOPwAtBu4Wp8EnJIN9j5Dy3uI7RBc9Uon8ImE+snewmWVEC
	 Cwt6bC6WgODcGCQGQxeb9+gUqhLBiudBqF8/zdEo9RGHW7mXpZq7I3W9sqbeFl3ocb
	 PCFDw1KaXXOcw==
Date: Thu, 6 Mar 2025 17:24:35 +0000
From: Jaegeuk Kim <jaegeuk@kernel.org>
To: Chao Yu <chao@kernel.org>
Cc: linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Revert "f2fs: rebuild nat_bits during umount"
Message-ID: <Z8naUxzVkLUYcjnJ@google.com>
References: <20250305110712.2114200-1-chao@kernel.org>
 <Z8hgoRHUbdaGxtpz@google.com>
 <06419a6c-ef99-412c-9ad5-88d734410c24@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <06419a6c-ef99-412c-9ad5-88d734410c24@kernel.org>

On 03/06, Chao Yu wrote:
> On 3/5/25 22:33, Jaegeuk Kim wrote:
> > Chao,
> > 
> > How about disabling nat_bits during mount and removing all the relevant codes
> > together?
> 
> Jaegeuk, let me do this in separated patches:
> - remove recovery code
> - disable by default
> - remove all other basic code
> 
> Otherwise, if we gather all changes in to one patch, it's hard to bisect
> code once there is a bug.

After refreshing myself, it seems we can keep the old nat_bits conservatively,
but remove this recovery code only w/ disable by default. Let's try this first.

> 
> Thanks,
> 
> > 
> > On 03/05, Chao Yu wrote:
> >> It reports that there is potential corruption in node footer,
> >> the most suspious feature is nat_bits, let's revert recovery
> >> related code.
> >>
> >> Signed-off-by: Chao Yu <chao@kernel.org>
> >> ---
> >>  fs/f2fs/checkpoint.c |  21 +++------
> >>  fs/f2fs/f2fs.h       |  32 +++++++++++++-
> >>  fs/f2fs/node.c       | 101 ++++++++++---------------------------------
> >>  3 files changed, 59 insertions(+), 95 deletions(-)
> >>
> >> diff --git a/fs/f2fs/checkpoint.c b/fs/f2fs/checkpoint.c
> >> index bc9369ea6607..1bc5c2006c56 100644
> >> --- a/fs/f2fs/checkpoint.c
> >> +++ b/fs/f2fs/checkpoint.c
> >> @@ -1348,21 +1348,13 @@ static void update_ckpt_flags(struct f2fs_sb_info *sbi, struct cp_control *cpc)
> >>  	struct f2fs_checkpoint *ckpt = F2FS_CKPT(sbi);
> >>  	unsigned long flags;
> >>  
> >> -	if (cpc->reason & CP_UMOUNT) {
> >> -		if (le32_to_cpu(ckpt->cp_pack_total_block_count) +
> >> -			NM_I(sbi)->nat_bits_blocks > BLKS_PER_SEG(sbi)) {
> >> -			clear_ckpt_flags(sbi, CP_NAT_BITS_FLAG);
> >> -			f2fs_notice(sbi, "Disable nat_bits due to no space");
> >> -		} else if (!is_set_ckpt_flags(sbi, CP_NAT_BITS_FLAG) &&
> >> -						f2fs_nat_bitmap_enabled(sbi)) {
> >> -			f2fs_enable_nat_bits(sbi);
> >> -			set_ckpt_flags(sbi, CP_NAT_BITS_FLAG);
> >> -			f2fs_notice(sbi, "Rebuild and enable nat_bits");
> >> -		}
> >> -	}
> >> -
> >>  	spin_lock_irqsave(&sbi->cp_lock, flags);
> >>  
> >> +	if ((cpc->reason & CP_UMOUNT) &&
> >> +			le32_to_cpu(ckpt->cp_pack_total_block_count) >
> >> +			sbi->blocks_per_seg - NM_I(sbi)->nat_bits_blocks)
> >> +		disable_nat_bits(sbi, false);
> >> +
> >>  	if (cpc->reason & CP_TRIMMED)
> >>  		__set_ckpt_flags(ckpt, CP_TRIMMED_FLAG);
> >>  	else
> >> @@ -1545,8 +1537,7 @@ static int do_checkpoint(struct f2fs_sb_info *sbi, struct cp_control *cpc)
> >>  	start_blk = __start_cp_next_addr(sbi);
> >>  
> >>  	/* write nat bits */
> >> -	if ((cpc->reason & CP_UMOUNT) &&
> >> -			is_set_ckpt_flags(sbi, CP_NAT_BITS_FLAG)) {
> >> +	if (enabled_nat_bits(sbi, cpc)) {
> >>  		__u64 cp_ver = cur_cp_version(ckpt);
> >>  		block_t blk;
> >>  
> >> diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
> >> index 6b4579b05dbf..8d8917b92b5d 100644
> >> --- a/fs/f2fs/f2fs.h
> >> +++ b/fs/f2fs/f2fs.h
> >> @@ -2231,6 +2231,36 @@ static inline void f2fs_up_write(struct f2fs_rwsem *sem)
> >>  #endif
> >>  }
> >>  
> >> +static inline void disable_nat_bits(struct f2fs_sb_info *sbi, bool lock)
> >> +{
> >> +	unsigned long flags;
> >> +	unsigned char *nat_bits;
> >> +
> >> +	/*
> >> +	 * In order to re-enable nat_bits we need to call fsck.f2fs by
> >> +	 * set_sbi_flag(sbi, SBI_NEED_FSCK). But it may give huge cost,
> >> +	 * so let's rely on regular fsck or unclean shutdown.
> >> +	 */
> >> +
> >> +	if (lock)
> >> +		spin_lock_irqsave(&sbi->cp_lock, flags);
> >> +	__clear_ckpt_flags(F2FS_CKPT(sbi), CP_NAT_BITS_FLAG);
> >> +	nat_bits = NM_I(sbi)->nat_bits;
> >> +	NM_I(sbi)->nat_bits = NULL;
> >> +	if (lock)
> >> +		spin_unlock_irqrestore(&sbi->cp_lock, flags);
> >> +
> >> +	kvfree(nat_bits);
> >> +}
> >> +
> >> +static inline bool enabled_nat_bits(struct f2fs_sb_info *sbi,
> >> +					struct cp_control *cpc)
> >> +{
> >> +	bool set = is_set_ckpt_flags(sbi, CP_NAT_BITS_FLAG);
> >> +
> >> +	return (cpc) ? (cpc->reason & CP_UMOUNT) && set : set;
> >> +}
> >> +
> >>  static inline void f2fs_lock_op(struct f2fs_sb_info *sbi)
> >>  {
> >>  	f2fs_down_read(&sbi->cp_rwsem);
> >> @@ -3695,7 +3725,6 @@ int f2fs_truncate_inode_blocks(struct inode *inode, pgoff_t from);
> >>  int f2fs_truncate_xattr_node(struct inode *inode);
> >>  int f2fs_wait_on_node_pages_writeback(struct f2fs_sb_info *sbi,
> >>  					unsigned int seq_id);
> >> -bool f2fs_nat_bitmap_enabled(struct f2fs_sb_info *sbi);
> >>  int f2fs_remove_inode_page(struct inode *inode);
> >>  struct page *f2fs_new_inode_page(struct inode *inode);
> >>  struct page *f2fs_new_node_page(struct dnode_of_data *dn, unsigned int ofs);
> >> @@ -3723,7 +3752,6 @@ int f2fs_recover_xattr_data(struct inode *inode, struct page *page);
> >>  int f2fs_recover_inode_page(struct f2fs_sb_info *sbi, struct page *page);
> >>  int f2fs_restore_node_summary(struct f2fs_sb_info *sbi,
> >>  			unsigned int segno, struct f2fs_summary_block *sum);
> >> -void f2fs_enable_nat_bits(struct f2fs_sb_info *sbi);
> >>  int f2fs_flush_nat_entries(struct f2fs_sb_info *sbi, struct cp_control *cpc);
> >>  int f2fs_build_node_manager(struct f2fs_sb_info *sbi);
> >>  void f2fs_destroy_node_manager(struct f2fs_sb_info *sbi);
> >> diff --git a/fs/f2fs/node.c b/fs/f2fs/node.c
> >> index 5f512dd5fadf..8c35fd4fa200 100644
> >> --- a/fs/f2fs/node.c
> >> +++ b/fs/f2fs/node.c
> >> @@ -2311,24 +2311,6 @@ static void __move_free_nid(struct f2fs_sb_info *sbi, struct free_nid *i,
> >>  	}
> >>  }
> >>  
> >> -bool f2fs_nat_bitmap_enabled(struct f2fs_sb_info *sbi)
> >> -{
> >> -	struct f2fs_nm_info *nm_i = NM_I(sbi);
> >> -	unsigned int i;
> >> -	bool ret = true;
> >> -
> >> -	f2fs_down_read(&nm_i->nat_tree_lock);
> >> -	for (i = 0; i < nm_i->nat_blocks; i++) {
> >> -		if (!test_bit_le(i, nm_i->nat_block_bitmap)) {
> >> -			ret = false;
> >> -			break;
> >> -		}
> >> -	}
> >> -	f2fs_up_read(&nm_i->nat_tree_lock);
> >> -
> >> -	return ret;
> >> -}
> >> -
> >>  static void update_free_nid_bitmap(struct f2fs_sb_info *sbi, nid_t nid,
> >>  							bool set, bool build)
> >>  {
> >> @@ -3010,23 +2992,7 @@ static void __adjust_nat_entry_set(struct nat_entry_set *nes,
> >>  	list_add_tail(&nes->set_list, head);
> >>  }
> >>  
> >> -static void __update_nat_bits(struct f2fs_nm_info *nm_i, unsigned int nat_ofs,
> >> -							unsigned int valid)
> >> -{
> >> -	if (valid == 0) {
> >> -		__set_bit_le(nat_ofs, nm_i->empty_nat_bits);
> >> -		__clear_bit_le(nat_ofs, nm_i->full_nat_bits);
> >> -		return;
> >> -	}
> >> -
> >> -	__clear_bit_le(nat_ofs, nm_i->empty_nat_bits);
> >> -	if (valid == NAT_ENTRY_PER_BLOCK)
> >> -		__set_bit_le(nat_ofs, nm_i->full_nat_bits);
> >> -	else
> >> -		__clear_bit_le(nat_ofs, nm_i->full_nat_bits);
> >> -}
> >> -
> >> -static void update_nat_bits(struct f2fs_sb_info *sbi, nid_t start_nid,
> >> +static void __update_nat_bits(struct f2fs_sb_info *sbi, nid_t start_nid,
> >>  						struct page *page)
> >>  {
> >>  	struct f2fs_nm_info *nm_i = NM_I(sbi);
> >> @@ -3035,7 +3001,7 @@ static void update_nat_bits(struct f2fs_sb_info *sbi, nid_t start_nid,
> >>  	int valid = 0;
> >>  	int i = 0;
> >>  
> >> -	if (!is_set_ckpt_flags(sbi, CP_NAT_BITS_FLAG))
> >> +	if (!enabled_nat_bits(sbi, NULL))
> >>  		return;
> >>  
> >>  	if (nat_index == 0) {
> >> @@ -3046,36 +3012,17 @@ static void update_nat_bits(struct f2fs_sb_info *sbi, nid_t start_nid,
> >>  		if (le32_to_cpu(nat_blk->entries[i].block_addr) != NULL_ADDR)
> >>  			valid++;
> >>  	}
> >> -
> >> -	__update_nat_bits(nm_i, nat_index, valid);
> >> -}
> >> -
> >> -void f2fs_enable_nat_bits(struct f2fs_sb_info *sbi)
> >> -{
> >> -	struct f2fs_nm_info *nm_i = NM_I(sbi);
> >> -	unsigned int nat_ofs;
> >> -
> >> -	f2fs_down_read(&nm_i->nat_tree_lock);
> >> -
> >> -	for (nat_ofs = 0; nat_ofs < nm_i->nat_blocks; nat_ofs++) {
> >> -		unsigned int valid = 0, nid_ofs = 0;
> >> -
> >> -		/* handle nid zero due to it should never be used */
> >> -		if (unlikely(nat_ofs == 0)) {
> >> -			valid = 1;
> >> -			nid_ofs = 1;
> >> -		}
> >> -
> >> -		for (; nid_ofs < NAT_ENTRY_PER_BLOCK; nid_ofs++) {
> >> -			if (!test_bit_le(nid_ofs,
> >> -					nm_i->free_nid_bitmap[nat_ofs]))
> >> -				valid++;
> >> -		}
> >> -
> >> -		__update_nat_bits(nm_i, nat_ofs, valid);
> >> +	if (valid == 0) {
> >> +		__set_bit_le(nat_index, nm_i->empty_nat_bits);
> >> +		__clear_bit_le(nat_index, nm_i->full_nat_bits);
> >> +		return;
> >>  	}
> >>  
> >> -	f2fs_up_read(&nm_i->nat_tree_lock);
> >> +	__clear_bit_le(nat_index, nm_i->empty_nat_bits);
> >> +	if (valid == NAT_ENTRY_PER_BLOCK)
> >> +		__set_bit_le(nat_index, nm_i->full_nat_bits);
> >> +	else
> >> +		__clear_bit_le(nat_index, nm_i->full_nat_bits);
> >>  }
> >>  
> >>  static int __flush_nat_entry_set(struct f2fs_sb_info *sbi,
> >> @@ -3094,7 +3041,7 @@ static int __flush_nat_entry_set(struct f2fs_sb_info *sbi,
> >>  	 * #1, flush nat entries to journal in current hot data summary block.
> >>  	 * #2, flush nat entries to nat page.
> >>  	 */
> >> -	if ((cpc->reason & CP_UMOUNT) ||
> >> +	if (enabled_nat_bits(sbi, cpc) ||
> >>  		!__has_cursum_space(journal, set->entry_cnt, NAT_JOURNAL))
> >>  		to_journal = false;
> >>  
> >> @@ -3141,7 +3088,7 @@ static int __flush_nat_entry_set(struct f2fs_sb_info *sbi,
> >>  	if (to_journal) {
> >>  		up_write(&curseg->journal_rwsem);
> >>  	} else {
> >> -		update_nat_bits(sbi, start_nid, page);
> >> +		__update_nat_bits(sbi, start_nid, page);
> >>  		f2fs_put_page(page, 1);
> >>  	}
> >>  
> >> @@ -3172,7 +3119,7 @@ int f2fs_flush_nat_entries(struct f2fs_sb_info *sbi, struct cp_control *cpc)
> >>  	 * during unmount, let's flush nat_bits before checking
> >>  	 * nat_cnt[DIRTY_NAT].
> >>  	 */
> >> -	if (cpc->reason & CP_UMOUNT) {
> >> +	if (enabled_nat_bits(sbi, cpc)) {
> >>  		f2fs_down_write(&nm_i->nat_tree_lock);
> >>  		remove_nats_in_journal(sbi);
> >>  		f2fs_up_write(&nm_i->nat_tree_lock);
> >> @@ -3188,7 +3135,7 @@ int f2fs_flush_nat_entries(struct f2fs_sb_info *sbi, struct cp_control *cpc)
> >>  	 * entries, remove all entries from journal and merge them
> >>  	 * into nat entry set.
> >>  	 */
> >> -	if (cpc->reason & CP_UMOUNT ||
> >> +	if (enabled_nat_bits(sbi, cpc) ||
> >>  		!__has_cursum_space(journal,
> >>  			nm_i->nat_cnt[DIRTY_NAT], NAT_JOURNAL))
> >>  		remove_nats_in_journal(sbi);
> >> @@ -3225,18 +3172,15 @@ static int __get_nat_bitmaps(struct f2fs_sb_info *sbi)
> >>  	__u64 cp_ver = cur_cp_version(ckpt);
> >>  	block_t nat_bits_addr;
> >>  
> >> +	if (!enabled_nat_bits(sbi, NULL))
> >> +		return 0;
> >> +
> >>  	nm_i->nat_bits_blocks = F2FS_BLK_ALIGN((nat_bits_bytes << 1) + 8);
> >>  	nm_i->nat_bits = f2fs_kvzalloc(sbi,
> >>  			F2FS_BLK_TO_BYTES(nm_i->nat_bits_blocks), GFP_KERNEL);
> >>  	if (!nm_i->nat_bits)
> >>  		return -ENOMEM;
> >>  
> >> -	nm_i->full_nat_bits = nm_i->nat_bits + 8;
> >> -	nm_i->empty_nat_bits = nm_i->full_nat_bits + nat_bits_bytes;
> >> -
> >> -	if (!is_set_ckpt_flags(sbi, CP_NAT_BITS_FLAG))
> >> -		return 0;
> >> -
> >>  	nat_bits_addr = __start_cp_addr(sbi) + BLKS_PER_SEG(sbi) -
> >>  						nm_i->nat_bits_blocks;
> >>  	for (i = 0; i < nm_i->nat_bits_blocks; i++) {
> >> @@ -3253,12 +3197,13 @@ static int __get_nat_bitmaps(struct f2fs_sb_info *sbi)
> >>  
> >>  	cp_ver |= (cur_cp_crc(ckpt) << 32);
> >>  	if (cpu_to_le64(cp_ver) != *(__le64 *)nm_i->nat_bits) {
> >> -		clear_ckpt_flags(sbi, CP_NAT_BITS_FLAG);
> >> -		f2fs_notice(sbi, "Disable nat_bits due to incorrect cp_ver (%llu, %llu)",
> >> -			cp_ver, le64_to_cpu(*(__le64 *)nm_i->nat_bits));
> >> +		disable_nat_bits(sbi, true);
> >>  		return 0;
> >>  	}
> >>  
> >> +	nm_i->full_nat_bits = nm_i->nat_bits + 8;
> >> +	nm_i->empty_nat_bits = nm_i->full_nat_bits + nat_bits_bytes;
> >> +
> >>  	f2fs_notice(sbi, "Found nat_bits in checkpoint");
> >>  	return 0;
> >>  }
> >> @@ -3269,7 +3214,7 @@ static inline void load_free_nid_bitmap(struct f2fs_sb_info *sbi)
> >>  	unsigned int i = 0;
> >>  	nid_t nid, last_nid;
> >>  
> >> -	if (!is_set_ckpt_flags(sbi, CP_NAT_BITS_FLAG))
> >> +	if (!enabled_nat_bits(sbi, NULL))
> >>  		return;
> >>  
> >>  	for (i = 0; i < nm_i->nat_blocks; i++) {
> >> -- 
> >> 2.48.1

