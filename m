Return-Path: <linux-kernel+bounces-405832-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BB749C57C6
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 13:31:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 141D41F228E8
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 12:31:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9A5A1CD21F;
	Tue, 12 Nov 2024 12:31:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="PjPFS+Oh"
Received: from smtp-relay-canonical-1.canonical.com (smtp-relay-canonical-1.canonical.com [185.125.188.121])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 790AF1591F0
	for <linux-kernel@vger.kernel.org>; Tue, 12 Nov 2024 12:31:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.121
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731414709; cv=none; b=YjLEZcyRER3UTnbGauU+sZU2eOI7dBaD4bwdVqpb/WWzUydz5B3UaMsRIvkevvuoDr7u21di2yzpfySFUkwOHe+QG/YdsEtmU+v0btu3Pf6+5rtMwWLT7nRi3Fc4b1/zPAWAvZBlrvMNO3AnESbj5siW9SGkLCeMqDH9lodTRZc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731414709; c=relaxed/simple;
	bh=19TZmgmT29SKJlnqr5XL8rtvlny1e6S1ooKBVb3p4xQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=f3I1XvehWrhDR5Btli2vKeUfqc85NVU2B00wr6Wg9Ph2Krb+sGiajvNrKoW7eldiwI1Y/k7O0iHiONyrOYz09eO92bNNWUM3HuUG9yhDEOFaTp7ZZ0DZWzW0JI5lqFSDNEVzZPTiF/SQDUhTVupvSrtRXhxv2Gqa4WfS0ZZubHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=PjPFS+Oh; arc=none smtp.client-ip=185.125.188.121
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from [192.168.1.174] (82-65-169-98.subs.proxad.net [82.65.169.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-canonical-1.canonical.com (Postfix) with ESMTPSA id 75B9040277;
	Tue, 12 Nov 2024 12:31:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1731414704;
	bh=30etB1MiHcCi54okGyvvATuicH2sASIJxCSkk0mrZAs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type;
	b=PjPFS+OhTH9lWc+m7BlCOlXkJBull/+YshPB7MeyJ/JzoAcw70qF8fDnR3FGVB+vY
	 Qc/SgTQVkpdV7nAj9IxiseUJXplssWyezqfqkZA+wGOsnsubUmxGVF7Fc3jMnAbGGm
	 khJd0o7qP5VhyDBWImcYX/hL2h+ymOnxlzUKxddvcptBfdEIciO4OZBS42/qIDO3PP
	 KUIvY3If/2PDkImzmODeAHeyBkL1pIUcXZC0/DcehsMiiJgdJdwiN/a1YI0auA1PC1
	 PXyZzccCDmmrfoU4LDalDOSZ8SdJTKugbSwDcFwkXUm2a25/M1wxwClUuXVYgVkBik
	 Hp1/HuBsTvzWA==
Message-ID: <f23ce482-89d3-4198-8129-d0187fb04658@canonical.com>
Date: Tue, 12 Nov 2024 13:31:44 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ufs: ufs_sb_private_info: remove unused s_{2,3}apb fields
To: linux-kernel@vger.kernel.org
Cc: Jeff Johnson <quic_jjohnson@quicinc.com>,
 Andrew Morton <akpm@linux-foundation.org>
References: <20241112114445.28767-1-agathe.porte@canonical.com>
Content-Language: en-US
From: Agathe Porte <agathe.porte@canonical.com>
In-Reply-To: <20241112114445.28767-1-agathe.porte@canonical.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Replaced by v2 
https://lore.kernel.org/linux-kernel/20241112120304.32452-1-agathe.porte@canonical.com/T/#t 


Which was replaced by v3: 
https://lore.kernel.org/linux-kernel/20241112122000.35610-1-agathe.porte@canonical.com/T/#t

On 12/11/2024 12:44, Agathe Porte wrote:
> These two fields are populated during and stored as a "frequently used
> value" in ufs_fill_super, but are not used afterwards in the driver.
>
> Moreover, one of the shifts triggers UBSAN: shift-out-of-bounds when
> apbshift is 12 because 12 * 3 = 36 and 1 << 36 does not fit in the 32
> bit integer used to store the value.
>
> Closes: https://bugs.launchpad.net/ubuntu/+source/linux/+bug/2087853
> Signed-off-by: Agathe Porte <agathe.porte@canonical.com>
> ---
>   fs/ufs/super.c  | 4 ----
>   fs/ufs/ufs_fs.h | 4 ----
>   2 files changed, 8 deletions(-)
>
> diff --git a/fs/ufs/super.c b/fs/ufs/super.c
> index bc625788589c..7ea1a4c07ba2 100644
> --- a/fs/ufs/super.c
> +++ b/fs/ufs/super.c
> @@ -1240,11 +1240,7 @@ static int ufs_fill_super(struct super_block *sb, void *data, int silent)
>   	else
>   		uspi->s_apbshift = uspi->s_bshift - 2;
>   
> -	uspi->s_2apbshift = uspi->s_apbshift * 2;
> -	uspi->s_3apbshift = uspi->s_apbshift * 3;
>   	uspi->s_apb = 1 << uspi->s_apbshift;
> -	uspi->s_2apb = 1 << uspi->s_2apbshift;
> -	uspi->s_3apb = 1 << uspi->s_3apbshift;
>   	uspi->s_apbmask = uspi->s_apb - 1;
>   	uspi->s_nspfshift = uspi->s_fshift - UFS_SECTOR_BITS;
>   	uspi->s_nspb = uspi->s_nspf << uspi->s_fpbshift;
> diff --git a/fs/ufs/ufs_fs.h b/fs/ufs/ufs_fs.h
> index ef9ead44776a..0905f9a16b91 100644
> --- a/fs/ufs/ufs_fs.h
> +++ b/fs/ufs/ufs_fs.h
> @@ -775,12 +775,8 @@ struct ufs_sb_private_info {
>   
>   	__u32	s_fpbmask;	/* fragments per block mask */
>   	__u32	s_apb;		/* address per block */
> -	__u32	s_2apb;		/* address per block^2 */
> -	__u32	s_3apb;		/* address per block^3 */
>   	__u32	s_apbmask;	/* address per block mask */
>   	__u32	s_apbshift;	/* address per block shift */
> -	__u32	s_2apbshift;	/* address per block shift * 2 */
> -	__u32	s_3apbshift;	/* address per block shift * 3 */
>   	__u32	s_nspfshift;	/* number of sector per fragment shift */
>   	__u32	s_nspb;		/* number of sector per block */
>   	__u32	s_inopf;	/* inodes per fragment */

