Return-Path: <linux-kernel+bounces-335168-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FE4297E225
	for <lists+linux-kernel@lfdr.de>; Sun, 22 Sep 2024 17:05:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E66BDB20CBB
	for <lists+linux-kernel@lfdr.de>; Sun, 22 Sep 2024 15:05:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBC59168C4;
	Sun, 22 Sep 2024 15:05:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="k3lUn4nu"
Received: from msa.smtpout.orange.fr (msa-209.smtpout.orange.fr [193.252.23.209])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C753EB663
	for <linux-kernel@vger.kernel.org>; Sun, 22 Sep 2024 15:05:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.252.23.209
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727017516; cv=none; b=pCKrlRvqOA28mFwMQKKNsectdnf0551ZrEkrPrS+bEshp00vehDwZPONMNgEkQVIOisrLzrtleHZcwQxD+xcnVbHjoBhuSJ/WF59sTdlF7IfS1kLpOv05wJoTdPnZ9dm0ZzxS/4UUO+8jKQPuM9y+oXf57Oo7JN5FDOVmICriyw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727017516; c=relaxed/simple;
	bh=FLJlMGeQMAVSWoBfazcku5jsQ3gGLL3eshwOJNYLhH4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RjkzyS0hXm3MOfyJ7cXbEE5qKNZfo0JuZPzJb3Exkun7cm2y6Q83n22LuI2/89vVsmRZhAMzOEdC6MVD2s0B8dPht1p9L0zq/8TV74WHN0Y/gbpNgdgrTf63VI89WYcGuRK9HZjXkCGsg5RNPbgOaYirPDeuA93SLX4nXvN6UWw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=k3lUn4nu; arc=none smtp.client-ip=193.252.23.209
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from [192.168.1.37] ([90.11.132.44])
	by smtp.orange.fr with ESMTPA
	id sO90slqsiQFOvsO91s9NY1; Sun, 22 Sep 2024 17:05:04 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1727017504;
	bh=NMjmSaHHL4SeXAUDeYQYO6hrQEms9KyingeFrUsyFx8=;
	h=Message-ID:Date:MIME-Version:Subject:To:From;
	b=k3lUn4nuy7o7OTmByFlC+DEFGcQIKhTIkcafOYwCK7ZYkmkqTFP0rNWMQninCIgOY
	 0RRkgQpToT7ygIMUzxFI/FiTMT1smonff0wzfZoZ+lzaqSOsqnt1qJcSMng3u+i00K
	 EWW/l26BCnLM+wWp8eV+Z+ocWIb4YqICe8bVtE2Xf/l+cup+6gvLl3uW6zYV5vhx39
	 Pz3wZpAuX73mh6DUk1Oafs6eNbydyyXImPh5MZz+P1+LjX9SYIHWhZEuzbuXOU4Yk7
	 59LLKvn2k/IAjZlWUQqd1G2Vnboso0h4GBed7SYHjLfikyblfTlX5z2TXmvGu6TqFV
	 lItpDLVXLodbw==
X-ME-Helo: [192.168.1.37]
X-ME-Auth: bWFyaW9uLmphaWxsZXRAd2FuYWRvby5mcg==
X-ME-Date: Sun, 22 Sep 2024 17:05:04 +0200
X-ME-IP: 90.11.132.44
Message-ID: <c9f80af9-4cf0-4b6e-8c61-4b7a6f287cd9@wanadoo.fr>
Date: Sun, 22 Sep 2024 17:05:01 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] jfs: fix array-index-out-of-bounds
To: Ghanshyam Agrawal <ghanshyam1898@gmail.com>, shaggy@kernel.org,
 ghandatmanas@gmail.com, jlayton@kernel.org, eadavis@qq.com,
 brauner@kernel.org
Cc: jfs-discussion@lists.sourceforge.net, linux-kernel@vger.kernel.org,
 syzbot+808f3f84407f08a93022@syzkaller.appspotmail.com
References: <20240922110000.128650-1-ghanshyam1898@gmail.com>
Content-Language: en-US, fr-FR
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
In-Reply-To: <20240922110000.128650-1-ghanshyam1898@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Le 22/09/2024 à 13:00, Ghanshyam Agrawal a écrit :
> In some cases, dn_numag may be greater than MAXAG which may
> result in an array-index-out-of-bounds in dbNextAG. Added
> a check to return an error code before we crash.
> 
> Reported-by: syzbot+808f3f84407f08a93022@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=808f3f84407f08a93022
> Signed-off-by: Ghanshyam Agrawal <ghanshyam1898@gmail.com>
> ---
>   fs/jfs/jfs_imap.c | 3 +++
>   1 file changed, 3 insertions(+)
> 
> diff --git a/fs/jfs/jfs_imap.c b/fs/jfs/jfs_imap.c
> index 2ec35889ad24..5088da13e8f1 100644
> --- a/fs/jfs/jfs_imap.c
> +++ b/fs/jfs/jfs_imap.c
> @@ -1360,6 +1360,9 @@ int diAlloc(struct inode *pip, bool dir, struct inode *ip)
>   	if (agno < 0 || agno > dn_numag)
>   		return -EIO;
>   
> +	if (unlikely(dn_numag > MAXAG))

Hi,

looking at other places with checks with MAXAG, I wonder if it should be >=?

CJ

> +		return -EIO;
> +
>   	if (atomic_read(&JFS_SBI(pip->i_sb)->bmap->db_active[agno])) {
>   		/*
>   		 * There is an open file actively growing.  We want to


