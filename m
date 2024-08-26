Return-Path: <linux-kernel+bounces-302027-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 53F3F95F8E2
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 20:20:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0EFFF282507
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 18:20:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC93581AB1;
	Mon, 26 Aug 2024 18:20:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="pCeIoNc1";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="EKX4WwFj"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CC61770F3
	for <linux-kernel@vger.kernel.org>; Mon, 26 Aug 2024 18:20:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724696438; cv=none; b=MRcT6/ULplAfdVm6kdd78FjO7aEa+0OcK5dlqwXolG3n6ylOzFGAjY+JmC0pi4Sa1oeFQ6fMCYZsCKfla0rSHxEH3D3GqkqlExoAmXJmhgIPqv4IK2xIUs4Vm9bsopfBbbkkGDyI3l2WHfUkH7uu7V26RB8fMpyHjRWtz4or+CU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724696438; c=relaxed/simple;
	bh=jqH4p6Nw18tAAVjtgyf5O1c/2Bgr8+Vg5Ak0/Hl5ZAc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IKGeMCZgKpmGR8fWqDToxqbTMdg7uoVw8rf625ndd+BqnxlukL9I0LMtJbZXNhV77/2BBzrCzMDQvnXQBTSYY/ckS5If+h2H/cifEkMQevZ3XAlCYoVfyqMhqRbHmhrpMlbC2Q0+jpU8dArkqYjcDmRSMi+q/wnwgHTlp1zVud0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=pCeIoNc1; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=EKX4WwFj; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 26 Aug 2024 20:20:29 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1724696434;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=pwu1YPkn2SOZ6n+Tw+G2w/asRhWOnCADZBLFWLzmw7g=;
	b=pCeIoNc1LW3n0GEiXAMtMOPvbCGep9ie8uydOdx3CfSn88s0TtdgHIy7p6ACns2j8qMn3H
	vdz3bS/zgjGFRijhK3ns4UPcthWLKwx5jMByaioj2rJeQZ3vZ6cPp94dCXYYJQZWjE89s7
	STK3HORQs+VbgcJDWsEsbnljjOoddu+LqamFSUX93CPWDgO3DXbV2nzBOr+m5MrszlPLt5
	9+jojg8RSpSZEATBA/qZZJHpSd0wd2X+7mVMwpCVb2exgj5Zk5PJ2Uu073hEFEkRVAp9Aq
	hd2nUdtTbPnLuFdOPqLWF5OEy92jwZy7/jligr5VycHKdb5te5i2/djd6Bikow==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1724696434;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=pwu1YPkn2SOZ6n+Tw+G2w/asRhWOnCADZBLFWLzmw7g=;
	b=EKX4WwFj9VsIQ45afRP1iaTBmhw78HWnJh3JrRgk2CCYKQCzOkmzS/UCPSfL4lMmHGnsNh
	HBUlFNyh7GZN2RCA==
From: Nam Cao <namcao@linutronix.de>
To: Alien Wesley <alienwesley51@gmail.com>
Cc: gregkh@linuxfoundation.org, linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org, ~lkcamp/patches@lists.sr.ht
Subject: Re: [PATCH v3] staging: rtl8192e: Fix multiple assignments in
 rtl_wx.c:529
Message-ID: <20240826182029.ZFtqcPCP@linutronix.de>
References: <20240826162804.18996-1-alienwesley51@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240826162804.18996-1-alienwesley51@gmail.com>

On Mon, Aug 26, 2024 at 01:28:04PM -0300, Alien Wesley wrote:
> Separated assignments for pairwise_key_type and group_key_type
> in order to silence the following checkpatch warning.
> 
> CHECK: multiple assignments should be avoided.
> 
> Signed-off-by: Alien Wesley <alienwesley51@gmail.com>
> ---
> v3: Fix typo in commit message.
> v2: Removed two spaces in front of "=".
> ---
>  drivers/staging/rtl8192e/rtl8192e/rtl_wx.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/staging/rtl8192e/rtl8192e/rtl_wx.c b/drivers/staging/rtl8192e/rtl8192e/rtl_wx.c
> index 47f1adf30ab4..67c4793e0fc1 100644
> --- a/drivers/staging/rtl8192e/rtl8192e/rtl_wx.c
> +++ b/drivers/staging/rtl8192e/rtl8192e/rtl_wx.c
> @@ -526,7 +526,7 @@ static int _rtl92e_wx_set_enc(struct net_device *dev,
>  	mutex_unlock(&priv->wx_mutex);
>  
>  	if (wrqu->encoding.flags & IW_ENCODE_DISABLED) {
> -		ieee->pairwise_key_type  = KEY_TYPE_NA;
> +		ieee->pairwise_key_type = KEY_TYPE_NA;

I was completely confused, because the desscription says "Fix multiple
assignments", yet I only see a whitespace fix.

So I looked at v1, and it makes sense, you are sending this as a follow-up
fix for a double-space issue that you added in v1.

Instead of doing this, please just squash your v1 and v3 patches together
and send it as v4. This v3 patch doesn't make sense on its own.

Best regards,
Nam

