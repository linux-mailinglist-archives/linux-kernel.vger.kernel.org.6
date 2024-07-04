Return-Path: <linux-kernel+bounces-240994-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B671927575
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 13:48:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2C89328261D
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 11:48:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BE381AD3F4;
	Thu,  4 Jul 2024 11:48:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="IoyZ3fM2"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B49F16A945;
	Thu,  4 Jul 2024 11:48:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720093719; cv=none; b=TGcDyzvcT5iKRbXBK9ytVi1b9MyX9cmyk8mUuGioRO73vXW8Pw4dZ8P/9QVX1T9Ou6wNxtdoJzWqkZ7xLHLtUvXe+J2eNs67ytfFAxvgOYcLqy5tUQegOlGKkElQRzf9maiuBI5oytmUwhUSSNeEvvfRt7Km+tNpxBWnEDHhn48=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720093719; c=relaxed/simple;
	bh=c4OshHpTxBAdoC0PCCGARRV97ciDLNCp+eTfY08+D8w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mxG1SVInaayVpyKZFoUvQJ6khiZdKKIeUbv4LgHM2hcDqyBY1dAWZRnl9ZKjV8Wq0B9hAwF9wZry9HgF77oxTKsvJ/uCnHNw+02PIymHExvUf8xXgt2qRRLmsPLQ/wVYFM6W+d7GGwLwN18cNKQui+G7t5HEUsvM2SyaOJ6UCt0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=IoyZ3fM2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23B2DC3277B;
	Thu,  4 Jul 2024 11:48:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1720093718;
	bh=c4OshHpTxBAdoC0PCCGARRV97ciDLNCp+eTfY08+D8w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=IoyZ3fM2L8dLuiR+jLFo4RN3qwSY8fZ4Blc4SBotEqbxybfC91Xyl8mMLJBCl3ixN
	 EmEzGDBN5Dd04NGlNtX+wrspAPikfUvw5DJoZHjan5FvNo9ejyzdJTq5X4WJbcl9RN
	 VJBLpd0G827Lnmzo/6/lB2LDDNZYYZekn4u1Yusc=
Date: Thu, 4 Jul 2024 13:48:35 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Akshay Gupta <akshay.gupta@amd.com>
Cc: linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux@roeck-us.net, arnd@arndb.de, naveenkrishna.chatradhi@amd.com
Subject: Re: [PATCH 0/6] misc: add amd side-band functionality
Message-ID: <2024070416-cosponsor-barrack-6125@gregkh>
References: <20240704111624.1583460-1-akshay.gupta@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240704111624.1583460-1-akshay.gupta@amd.com>

On Thu, Jul 04, 2024 at 11:16:18AM +0000, Akshay Gupta wrote:
> AMD's APML interface provides system management functionality accessed by
> the BMC. Sbrmi driver under hwmon subsystem, which is probed as an i2c
> driver and reports power using APML specified protocol.

What is "APML"?  What is "BMC"?

> However, APML interface defines few other protocols to support
> full system management functionality out-of-band.

What is out-of-band here?

> This patchset is an attempt to add all APML core functionality in one place
> and provide hwmon and user interface
> 1. Move the i2c client probe and sbrmi core functionality from drivers/hwmon
>    to drivers/misc/
> 2. Add a platform device, which probes the hwmon/sbrmi and continues to
>    report power using the symbol exported by the misc/sbrmi-core.

Are you sure this is a platform device?  It better not be a pci one...

> 3. Convert i2c to regmap which provides multiple benefits
>    over direct smbus APIs.

What are those?

> 4. Register a misc device which provides 
>     a. An ioctl interface through node /dev/sbrmiX

Why?

>     b. Open-sourced and widely used https://github.com/amd/esmi_oob_library
>        will continue to provide user-space programmable API.

Will this use the new ioctl api?  If it's not present, what will it use
instead?

thanks,

greg k-h

