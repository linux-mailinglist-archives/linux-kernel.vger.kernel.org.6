Return-Path: <linux-kernel+bounces-268762-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B74C942901
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 10:17:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C24471F2444B
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 08:17:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01D291A7F91;
	Wed, 31 Jul 2024 08:16:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="J69oA/1g"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3712D1A76CA;
	Wed, 31 Jul 2024 08:16:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722413810; cv=none; b=mjAljCpMOWKL6PxvW9vCdlajmipcEKs8JdguXYqeluV7kWcBLMdTfST3BJCo5ykqiN3676sKvD6M8f98NqoMVoWwzooZCT/uvMuhraz9S4wPGb+fRRiqSZ6Tpw5FohMk2pOM2VHhw7OWTP0f8HSVMi92jj8JKE8wWNHVqOw70jY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722413810; c=relaxed/simple;
	bh=O6Xz2QSiCObgEjbdQCsXEFgjz5q5R2zyAGO7GLONOrQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UGwsDZarwA4LN+CjMNY/BBdi8Ua6TWvWtTAH4tTQMgCa2L6OE4TR3vkOEX9DStpuxzwFCJBPMwodM2Nr+zjJeDnGEj80UB+/6BHnO4UgZsBu1pAEqzMqmkX4Eo7pG3oHZH6NwD4VLa2wTcW9+F3a2lk8CbSG30aMi++sAta5KkA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=J69oA/1g; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6394DC116B1;
	Wed, 31 Jul 2024 08:16:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1722413809;
	bh=O6Xz2QSiCObgEjbdQCsXEFgjz5q5R2zyAGO7GLONOrQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=J69oA/1gqkTEEt9P5A1jqJBsPDPRXuHeCouvuWXEahk+jA0fDfsi35NQ6a7hGTem5
	 9K8NhsnC6SIjzHAPXI3rXBiblrJ+EdtE9ISBb9XilcbnPPjHR0nYZ4RuoDgGPJ/+7n
	 rj5VlM7DRzQj8KRHx2lkbi2dloObXtJNvOAM70DU=
Date: Wed, 31 Jul 2024 10:16:46 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Johan Hovold <johan@kernel.org>
Cc: linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [GIT PULL] USB-serial updates for 6.11-rc1
Message-ID: <2024073134-mobster-unarmored-1d50@gregkh>
References: <ZpUUwvgpSEj8mojg@hovoldconsulting.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZpUUwvgpSEj8mojg@hovoldconsulting.com>

On Mon, Jul 15, 2024 at 02:23:30PM +0200, Johan Hovold wrote:
> The following changes since commit 22a40d14b572deb80c0648557f4bd502d7e83826:
> 
>   Linux 6.10-rc6 (2024-06-30 14:40:44 -0700)
> 
> are available in the Git repository at:
> 
>   https://git.kernel.org/pub/scm/linux/kernel/git/johan/usb-serial.git tags/usb-serial-6.11-rc1
> 
> for you to fetch changes up to df8c0b8a03e871431587a13a6765cb4c601e1573:
> 
>   USB: serial: garmin_gps: use struct_size() to allocate pkt (2024-07-05 14:01:43 +0200)
> 

Sorry for the delay, now queued up for 6.11-final.

greg k-h

