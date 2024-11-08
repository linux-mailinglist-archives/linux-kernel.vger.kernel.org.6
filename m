Return-Path: <linux-kernel+bounces-401192-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 054209C1711
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 08:37:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 36CDB1C227EF
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 07:37:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60B8E1D1735;
	Fri,  8 Nov 2024 07:37:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="P/kNxeSN"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3B12197A82;
	Fri,  8 Nov 2024 07:37:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731051441; cv=none; b=hvH7B7neM/JY+TNpmTdnsxqVAsgUz0qmh8r0kGf3zaiGD26C2GK9cpNGRBdFlQ6uQ9ivk46B6ifCk1mlaDORjA41NA3Ip04quu9jsQ721f3KcctI7c83+ktUKaiJFdIgeDrNzW3+v3DF8OEd4cSMv3R+CFhknjsIfuan55v0adI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731051441; c=relaxed/simple;
	bh=wlN/xGHW3C7fYCgR4LNZICcDH/wCALbPrqG44/dwOlA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GoRLmuqBL50mPgqdpe8Nr7rUObmyLw931uWNLa2cUnmEmArikYACIY5mJgyx4idPAxycL+TK/cJctxqd46xHtkzaC2/DdghPyIlgHBQhM1hCum9rdtPM/iRRyj+N4R9Re2IhmXsA8jxguyUVT3OJRh2iMqzP5ketThBgw9bfKn0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=P/kNxeSN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E89E2C4CECE;
	Fri,  8 Nov 2024 07:37:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1731051441;
	bh=wlN/xGHW3C7fYCgR4LNZICcDH/wCALbPrqG44/dwOlA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=P/kNxeSN6VCOKWewWlHLmy96Jgx2So8ZwsNbz1L1FVL57uo0uA901v81anGTR9BOu
	 MNkQKhq8HA2GQBiCG2iiP+Z2+7IVkglLeTu71zTPJcH3pJOeUGvKAxilQ3oR2z0HpR
	 gCnnAwA8nyRCVlZdxCEFdSMBWaHFA+W9S5L5goN0=
Date: Fri, 8 Nov 2024 08:36:54 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Johan Hovold <johan@kernel.org>
Cc: linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [GIT PULL] USB-serial fixes for 6.12-rc7
Message-ID: <2024110844-armful-eliminate-e189@gregkh>
References: <Zy2-G5Q_9ECZsu9q@hovoldconsulting.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zy2-G5Q_9ECZsu9q@hovoldconsulting.com>

On Fri, Nov 08, 2024 at 08:30:35AM +0100, Johan Hovold wrote:
> The following changes since commit 42f7652d3eb527d03665b09edac47f85fb600924:
> 
>   Linux 6.12-rc4 (2024-10-20 15:19:38 -0700)
> 
> are available in the Git repository at:
> 
>   https://git.kernel.org/pub/scm/linux/kernel/git/johan/usb-serial.git tags/usb-serial-6.12-rc7

Pulled and pushed out, thanks.

greg k-h

