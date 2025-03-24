Return-Path: <linux-kernel+bounces-573981-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 58C17A6DF3B
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 17:05:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1896F18921A4
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 16:05:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 149DA261584;
	Mon, 24 Mar 2025 16:05:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C/EPK/dD"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 743C341C85
	for <linux-kernel@vger.kernel.org>; Mon, 24 Mar 2025 16:05:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742832313; cv=none; b=QqgH003MrGKvlvJOycsKBy5SjEeC/4c+pbVL4Am+QXj5EPTIIjxoOGOFq0GDK/0mbIY/S2j/00VbCx+eZVd2Mt9AqADOvFKYW/UFdBSkO20zo1O2j9fqiVZ11xqVEmwx2ELdmQoN0qA8ut9weU/L2zgbuh9RePHSMOh1UaOridQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742832313; c=relaxed/simple;
	bh=IT2XmJJcEYDTRA3U2J8Ikve5HF+HyGqJh2t6BVa75TI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rKrpFeBOLKtNzh3+jV5uWZ0ddfIR7x22ukwf6nu5oQH5TV4tr+BPCuXMThQQztCpZNil7e/1NabaHQzSusmNFk3oOnrwYJ/f6C8QCgKx0jgjSP5gyk+kiK0ko9gcuSjS3232lOehxz3wvRf7QHedDQQzEqUYSSTaDuw00MfFClk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C/EPK/dD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2EF52C4CEDD;
	Mon, 24 Mar 2025 16:05:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742832313;
	bh=IT2XmJJcEYDTRA3U2J8Ikve5HF+HyGqJh2t6BVa75TI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=C/EPK/dDqft5JDasPEkhG35tpiJoUGPbCKA3vo9r/52WLoG7mq9FhzksvbEs4i56D
	 R2jjobr6qbo9X91yRROKNWlLOfgD49hJPfjSacV6IIb+aNhIo6lbENuMIB4oBYuTUB
	 uM7OiZjL67cBumneiUa/oVjtAqDGWueaE2iJvprDFT/Hc8ppmQa6q3r/zBgikD/V0Y
	 L5eNg/YjR5UY6W5RQvsGpS2dm4l5fqZMhF8fbSTSB8oC3iVqG3bec39uzvXDbdDErD
	 +/3lFjMuHx1dhrmh0K1tQ/U/OUnZKkh7SY2Y5F9QJOTTcKZlylU+oE/vtoQVxaglLC
	 DG81j2h6y1GOw==
Date: Mon, 24 Mar 2025 11:05:12 -0500
From: Rob Herring <robh@kernel.org>
To: Goran =?utf-8?B?UmHEkWVub3ZpxIc=?= <goran.radni@gmail.com>
Cc: Goran =?utf-8?B?UmHEkWVub3ZpxIc=?= <gradenovic@ultratronik.de>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/4] MAINTAINERS: Add maintainers for Ultratronik SoC
 Boards
Message-ID: <20250324160512.GA129330-robh@kernel.org>
References: <20250321111821.361419-1-goran.radni@gmail.com>
 <20250321111821.361419-3-goran.radni@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250321111821.361419-3-goran.radni@gmail.com>

On Fri, Mar 21, 2025 at 12:18:17PM +0100, Goran Rađenović wrote:
> From: Goran Rađenović <gradenovic@ultratronik.de>
> 
> Add maintainers for Ultratronik SBC STM32MP1 board.
> 
> Signed-off-by: Goran Rađenović <gradenovic@ultratronik.de>
> ---
>  MAINTAINERS | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 00e94bec401e..26896dd2ceb3 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -24336,6 +24336,12 @@ S:	Maintained
>  F:	drivers/usb/common/ulpi.c
>  F:	include/linux/ulpi/
>  
> +ULTRATRONIK BOARD SUPPORT
> +M:	Goran Rađenović <goran.radni@gmail.com>
> +M:	Börge Strümpfel <boerge.struempfel@gmail.com>
> +S:	Maintained
> +F:	arch/arm/boot/dts/st/stm32mp157c-ultra-fly-sbc.dts

This file doesn't exist yet. Just squash this with patch #4.

Is this the only board? Perhaps make it a wildcard so the next board 
doesn't need a MAINTAINERS update.

> +
>  UNICODE SUBSYSTEM
>  M:	Gabriel Krisman Bertazi <krisman@kernel.org>
>  L:	linux-fsdevel@vger.kernel.org
> -- 
> 2.43.0
> 

