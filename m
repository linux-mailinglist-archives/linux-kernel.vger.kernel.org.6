Return-Path: <linux-kernel+bounces-304698-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E47159623AA
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 11:39:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5274BB231EE
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 09:39:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D40C158214;
	Wed, 28 Aug 2024 09:38:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="rqr5DNQO"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 571A9166F37;
	Wed, 28 Aug 2024 09:38:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724837902; cv=none; b=KBFme2Cj3WBEYIYLjLIO7UcsvSbGXbqwBz998RnCgzhbcaN9DuYgPqkCq8G/LQTOOFNGkB7OgcuE2gp9EKELynx0l8WWp6ywCw/JZxaW0mDY63U1+DqSzY+0UaqkjpPF5cYacMHjBtXKKdfBAIVIkXAU/y5xiCuSRWuf4+ERWE8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724837902; c=relaxed/simple;
	bh=1P391ktvKu7g7z8LSnqO0Vj/ydqSmaAj1NkseF+E4v0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=D7HC7Qnc/clnirqireuKmSNAksacPbFD/ov5QZCFMGUSobHcZR3rszTp7wCZgQEBsDnc6AnD04sNtO+/pfdFMnB/ebXAqi/OF8lmaM974bpjCHcXU7fS5DdA9R5gLDORxqZDtTMJtiWIWtdNKWCiTrv4wvvh+LPznfA0mGbNI2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=rqr5DNQO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61E54C98EC5;
	Wed, 28 Aug 2024 09:38:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1724837901;
	bh=1P391ktvKu7g7z8LSnqO0Vj/ydqSmaAj1NkseF+E4v0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=rqr5DNQOKkklFKA5+duFBivLD+Hjp8hBEIby3UhYznVmQolCNWztp1PAbQLOcgnWG
	 w9Hr+pnACaG9d66q0ODxsP781kiAqQmFNCuxDJ3YkE6SD/bEElMMJ9BfoEeJW/Nf9r
	 Y+hV6GfO0UGmplBkxl0N+gnwjpx+qMYSr8XH45oE=
Date: Wed, 28 Aug 2024 11:38:18 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: vivek t s <vivek6429.ts@gmail.com>
Cc: linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Staging: rtl8723bs: Rename function SelectChannel()
Message-ID: <2024082848-ice-unfixable-6a09@gregkh>
References: <Zs7vQXhcYRCxCDaH@victor-IdeaPad-Gaming-3-16IAH7>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zs7vQXhcYRCxCDaH@victor-IdeaPad-Gaming-3-16IAH7>

On Wed, Aug 28, 2024 at 03:04:57PM +0530, vivek t s wrote:
> --- a/drivers/staging/rtl8723bs/include/rtw_mlme_ext.h
> +++ b/drivers/staging/rtl8723bs/include/rtw_mlme_ext.h
> @@ -455,7 +455,7 @@ u8 rtw_get_center_ch(u8 channel, u8 chnl_bw, u8 chnl_offset);
>  unsigned long rtw_get_on_cur_ch_time(struct adapter *adapter);
>  
>  void set_channel_bwmode(struct adapter *padapter, unsigned char channel, unsigned char channel_offset, unsigned short bwmode);
> -void SelectChannel(struct adapter *padapter, unsigned char channel);
> +void select_channel(struct adapter *padapter, unsigned char channel);

This is a pretty horrible name for a symbol in the global namespace, can
you rename it to be more sane for this driver (i.e. put a prefix on it?)

thanks,

greg k-h

