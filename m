Return-Path: <linux-kernel+bounces-357406-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 365B59970EA
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 18:17:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BC9C12853BF
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 16:17:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AED182071FE;
	Wed,  9 Oct 2024 15:54:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gNoLKrhh"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DDAD2071F6
	for <linux-kernel@vger.kernel.org>; Wed,  9 Oct 2024 15:53:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728489240; cv=none; b=FYjxl8l2mTv78KHg97e3JAqTs4Uus5bCOCLbUOKSyJy+rElzmq1wvxnnFL6cnE2UwvqK7PW/ZRgP0j+YGSX6H7/n8FDPR17m/KKJFRhVv0bJHexuSZmD+A3eAMTAysXntzYjFvhtFtOSL7Vh2J6/BitF5nGLhe8il2qo78/uqa8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728489240; c=relaxed/simple;
	bh=DvcyOIuz7cmBVQEGrN35HSMEzG0hvzXjrP01M0NoF7E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=igSlwJ4YTmJlZVcJlcBo13aaL0ToGe503ck05+4kyWRY9gsKNEAOwit8ep5H9MbuZeeoOys/HN40+Ol7ZAfq8uXrnee+BrtCuvp40kxl+7rzK6o1CQAjLNH8Xm0/AswGNmidncVhGrEYRNdzy7VFGPe5xqii4AsdMt4coWZ/TDU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gNoLKrhh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1419C4CEC3;
	Wed,  9 Oct 2024 15:53:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728489239;
	bh=DvcyOIuz7cmBVQEGrN35HSMEzG0hvzXjrP01M0NoF7E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gNoLKrhhbEn4hRkHTgw9PIyhsCD/zKpuQxdd15PAJnuChUidv309LC8VRdsH0m3sf
	 ejEL95h56TUl60xj9p96awipWaiZJ5KjD/J6kYhZFO0qGmsQaOvzLXqWcQkYT3DSCA
	 m0cTwhNz8OAqFjm92DyrOtbRS7St0B0fVYAObfpXpucteO97cBKdoXdUBmEeq1eeG0
	 p6XpKAA5zc59cFKnvaEc0dhTw71CvUDx6Ik2hrmqV2K4uCbL/OcYTE3eB7zQlUdI37
	 xrrqJYxBW4fa83jo/YjD00OdkOcAGcuOsU67GnLhY8Ur19dOegwVctXaAuZuaI/mEk
	 L4PpxklOJBDBA==
Date: Wed, 9 Oct 2024 16:53:56 +0100
From: Lee Jones <lee@kernel.org>
To: Patrick Rudolph <patrick.rudolph@9elements.com>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] regulator: max5970: Drop unused structs
Message-ID: <20241009155356.GC637580@google.com>
References: <20241002125500.78278-1-patrick.rudolph@9elements.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241002125500.78278-1-patrick.rudolph@9elements.com>

On Wed, 02 Oct 2024, Patrick Rudolph wrote:

> After splitting the max5970 into a MFD device clean the remaining
> code and drop unused structs.
> 
> The struct max5970_data and enum max5970_chip_type aren't used.
> 
> Signed-off-by: Patrick Rudolph <patrick.rudolph@9elements.com>
> ---
>  drivers/regulator/max5970-regulator.c | 21 ++++-----------------
>  include/linux/mfd/max5970.h           | 12 ------------

Acked-by: Lee Jones <lee@kernel.org>

>  2 files changed, 4 insertions(+), 29 deletions(-)

-- 
Lee Jones [李琼斯]

