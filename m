Return-Path: <linux-kernel+bounces-263943-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 12ADA93DCF8
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jul 2024 03:42:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 46340B23235
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jul 2024 01:42:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7EC91878;
	Sat, 27 Jul 2024 01:42:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="qjxoUicB"
Received: from out162-62-57-210.mail.qq.com (out162-62-57-210.mail.qq.com [162.62.57.210])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 237DC15BB
	for <linux-kernel@vger.kernel.org>; Sat, 27 Jul 2024 01:42:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.57.210
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722044564; cv=none; b=hNkwkau/eB7HKbwLtuEioN9ASx3bCTvSdMpki9a8Wi47ItMDoo3q3dloKoI08itxK7oTtFKW0GQElkD2cFfBrFr8ayNd/413mYx48VNmCbK7tIPQe2ELk4BdTvQj67HWBo3fjhaXRVQfvR67cP7AZL5a4h8ZPLJ1JrgnQKA2jS8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722044564; c=relaxed/simple;
	bh=F1jC6e0yscKmoUQrnKK0B13Euq9ibniQly0rwP0K0cs=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=Ljrc87y8g0+ELYedswfEvoS5xvPhuc78Xcwlz72oQan1NXHWkyDU7Wg4jkyqJYnr0jRL5pyIWqYaLRu5Pv3Q9SCAh7Kpk7Lv2t+VzQJ4SfhAM54JyGWtWzKxL6EkLEfVfcknYHI2QYGa/Gpc/wLbzZkjAvxHhvAuYdLH5/CjKAE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=qjxoUicB; arc=none smtp.client-ip=162.62.57.210
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1722044551; bh=7SLdZ01xonqza949W0eAf//l/jirighpLzT6wAxM/GM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=qjxoUicBemrkQ0TWtCikHRP66+4zyppsp1stdrtsis9MnnfZ2c8GymwhGpAAvTvo8
	 EUk1N/32irPC9OezW09Et/h48MSjNtVzRDgsWabm4tEH0Bku3ANLdNL/3wxQweEAuu
	 5DsFKecMObf9BKk96EhuuW07+cMsBziamGTRcvVM=
Received: from pek-lxu-l1.wrs.com ([111.198.228.103])
	by newxmesmtplogicsvrszb16-1.qq.com (NewEsmtp) with SMTP
	id A9D1C086; Sat, 27 Jul 2024 09:42:29 +0800
X-QQ-mid: xmsmtpt1722044549tyo4sxqvf
Message-ID: <tencent_5D0479366FE42D1D6DD09554EA66ED9ACC0A@qq.com>
X-QQ-XMAILINFO: NvKyM24IHTKSRwfinymltxKRndFXX3PzaRQbjdfp32yz1UVYoZ2EQxQRajW98W
	 jNUfOUTZDE6Ydl47YwOjj5v2rYcTWmKNreLfvVbhdshJzR2JaazXQ9JXpSr6hracBgra6KxosLqu
	 Cq7Sd5xAyCFc645Q6audB8EAOahAxW9USUs4IpzCYTHSD2poO9qk34Dl2kuBZ4Wvo6eBY71jPgy4
	 UqsHbOs6J9gXB4xhkcqXK1vzIpfgrBDBidr5QB+2/p2VRnvqQUFheMRoxqHX7jXFaxox0LzfH6XH
	 b3U2ZL5+5UNuyfyKCz+9gtCOPozxuzocrNAOpx/kiAphrR8FgfJkccYHp8je14Tl3+sdifjQZKqm
	 hHHGya8196IHylfB/JEKsxNBAyX3aaAofo0NVvnO57xLuBSkrSUrLUqUQYTag7ORkbtk96ER+1UO
	 NHUJPkmW983ldWNVrZhiyobOF0xOeMp7VCFN6R5nAOYUXC7HVvvkFdJc7oo2/Gip67D43c/nRK/B
	 POoOawepPTOHdrAMTGqw5yIclZPSCVtgg0gwtsa3t82ln/jOFz3HJgJMEoEZZO6yBlhVujxNQWxE
	 GhWiQkShe4IMHp+8T4FDRWGFqt3JGHqfSp0b20AJyD3PynhMSzNmXmgngZEqleKeZV3whjE4Dp6t
	 2WK6HjXcEmJS250Ut/1gChGXo1gPRrUFSyrRS33i26ixo025I+5obi+eeMCODn6+jWB8CztyEfnt
	 6DV5eJsJCm8u4b+Ya4B6PiT7duPStNAUb2A74dmMxGjb18JxiMBXJouscs3gy/tb764zIOI98L3C
	 hZZaBnd/I5IHyB+fr8WSUWXYF1Ak5pCAhuGRSLxwnusS8OWa5NEbB3WPdeTK4v5tao1Ig1ypyyvw
	 aYgPiEinCKhLRkWKvc/sTe6dgTP9iqGKrSTsI3IZ9AiVpWC/hyxmaJzRl5pEsOYc8S9PU8IsLcs8
	 czjMKtya6ECxEYZf9Ncw==
X-QQ-XMRINFO: OD9hHCdaPRBwq3WW+NvGbIU=
From: Edward Adam Davis <eadavis@qq.com>
To: dave.kleikamp@oracle.com
Cc: eadavis@qq.com,
	jfs-discussion@lists.sourceforge.net,
	linux-kernel@vger.kernel.org,
	syzbot+dca05492eff41f604890@syzkaller.appspotmail.com,
	syzkaller-bugs@googlegroups.com
Subject: [PATCH V2] jfs: check if leafidx greater than num leaves per dmap tree
Date: Sat, 27 Jul 2024 09:42:30 +0800
X-OQ-MSGID: <20240727014229.2464364-2-eadavis@qq.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <c8b1c258-740a-412f-ae0b-4d68a53e698f@oracle.com>
References: <c8b1c258-740a-412f-ae0b-4d68a53e698f@oracle.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

syzbot report a out of bounds in dbSplit, it because dmt_leafidx greater
than num leaves per dmap tree, add a checking for dmt_leafidx in dbFindLeaf.

Reported-and-tested-by: syzbot+dca05492eff41f604890@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=dca05492eff41f604890
Signed-off-by: Edward Adam Davis <eadavis@qq.com>
---
 fs/jfs/jfs_dmap.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/jfs/jfs_dmap.c b/fs/jfs/jfs_dmap.c
index cb3cda1390ad..516bac758053 100644
--- a/fs/jfs/jfs_dmap.c
+++ b/fs/jfs/jfs_dmap.c
@@ -2976,6 +2976,8 @@ static int dbFindLeaf(dmtree_t *tp, int l2nb, int *leafidx, bool is_ctl)
 		 */
 		assert(n < 4);
 	}
+	if (le32_to_cpu(tp->dmt_leafidx) >= LPERDMAP)
+		return -ENOSPC;
 
 	/* set the return to the leftmost leaf describing sufficient
 	 * free space.
-- 
2.43.0


