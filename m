Return-Path: <linux-kernel+bounces-558136-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EB88A5E21C
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 17:57:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D293216CFEA
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 16:57:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7B0624BC09;
	Wed, 12 Mar 2025 16:57:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pCO+OOEs"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EE281C5D7A;
	Wed, 12 Mar 2025 16:57:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741798656; cv=none; b=Dy9kLIycaycQDS9K4dOQ0nvDKKDM5qxOksnlbwqyR1xv2scWtv3Z2XPdgKJqTr+ujiREpSnSQ/0TQCnObLU2klS7/haI4GkXnWoKjiLTwMLmg+3MSJOgFRlyffm4Tt2+oMXgNMV75NV+VnPi0IEvqJTGJn8pZqJraGlhV3SbMMA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741798656; c=relaxed/simple;
	bh=KmjQLnPp4YM/qGqzVKUQ7fVLv3A/PMnJn/rU8zIw1vE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aUC6pLYCcBsL4arm5XIeGuaBQkw8vhP7ShR6xLghI9Hn1+nSGbJ/w0/fRKcGTmFwFizmZW9e7ZRgweqfnUXoL2YHpc6Ga2y+b8FFKXXPIH2Dxp4ia9FtNHEUTma9UXIJuzOHcdnjscZUzUgWf2BBB6HI113oQUcDnxlaWhzsRSM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pCO+OOEs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C83DC4CEDD;
	Wed, 12 Mar 2025 16:57:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741798654;
	bh=KmjQLnPp4YM/qGqzVKUQ7fVLv3A/PMnJn/rU8zIw1vE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=pCO+OOEsYdh83XGEMEpNmB7KQCfGjUoa2Rlmbdt8/lwciuEX3ZruwEUsASQcPlkYc
	 UgaqLJiZdiqTQovHezD1zaFstN11Le5Ty/M9G8G+WHe0RY1CvaVs3alcux/j+DRtUQ
	 cX7Zg9WLLMzkLhrwCQ4DxICRloDu5RYmRwJuVA/N2IIzrNtS8A88fKZF71ndmpBGsJ
	 yKV3KXJPweZGhQ459X0dqJUFgvAvEeXsLRV+UIpPsHA8bjb2xg+KXM1AFW32PvPh6o
	 FJc4BXtMcNe11UWTjW3pEgPBX7Zc5jGsMltT37SVUdpoJBEMTmC1hj1AVx7lcikVMr
	 gMT5GmEEhdIeQ==
Received: from johan by xi.lan with local (Exim 4.97.1)
	(envelope-from <johan@kernel.org>)
	id 1tsPOd-000000000Sy-1Ryn;
	Wed, 12 Mar 2025 17:57:32 +0100
Date: Wed, 12 Mar 2025 17:57:31 +0100
From: Johan Hovold <johan@kernel.org>
To: Boon Khai Ng <boon.khai.ng@intel.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-usb <linux-usb@vger.kernel.org>,
	linux-kernel <linux-kernel@vger.kernel.org>,
	Boon Khai Ng <boon.khai.ng@altera.com>,
	Tien Sung Ang <tien.sung.ang@altera.com>
Subject: Re: [PATCH v3] USB: serial: ftdi_sio: add support for Altera USB
 Blaster 3
Message-ID: <Z9G8-66NI_5TLSY-@hovoldconsulting.com>
References: <20250312030544.4967-1-boon.khai.ng@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250312030544.4967-1-boon.khai.ng@intel.com>

On Wed, Mar 12, 2025 at 11:05:44AM +0800, Boon Khai Ng wrote:
> The Altera USB Blaster 3, available as both a cable and an on-board
> solution, is primarily used for programming and debugging FPGAs.

> These configurations allow for flexibility in how the USB Blaster 3 is
> used, depending on the specific needs of the hardware design.
> 
> ---
> 
> v3: Updated PID table.
> 
> PID table in the commit message in v2 missmatched with the PID macro
> defined in the header file, updated the correct table in v3.
> 
> ---
> 
> v2: Update commit message, added PID table, updated the macro name
> 
> Updated the commit message to include more information about the
> background of what is this change about. Added the PID table to
> clarify that the PID associated to the specific hardware configuration
> Updated the macro name in header file from ALTR to ALTERA and also
> the VID's macro name to ALTERA_VID
> 
> Signed-off-by: Boon Khai Ng <boon.khai.ng@intel.com>

Thanks for the update, now applied.

Next time, remember to put your SoB above the (first) cut-off line (---)
so that it is included in the commit message when your patch is applied.
I fixed that up manually this time.

Johan

