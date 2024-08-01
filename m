Return-Path: <linux-kernel+bounces-271864-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AD5D9945410
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 23:22:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 68D0C2860A7
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 21:22:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DD8714B949;
	Thu,  1 Aug 2024 21:22:37 +0000 (UTC)
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB76838DD6;
	Thu,  1 Aug 2024 21:22:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722547357; cv=none; b=ITFYv/KCDHG5lrSaiWnj7GonKKjWHZGH7WDw0yUKPBeLmTxoeZ9FI5DWJ0lzHFRBtA0mMZPambU8LL9hYd30fjF+BEANuJfwR1ZT11QfMNILhjGvYQ6WaWJ44GG0EyosqmMQDDcXy80+0XPTx07inlM6V4KxIKrzE83qQX9vhc8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722547357; c=relaxed/simple;
	bh=cOOxkB6cqWUVxy4AkVaCg/zdyGfn7cSpdO8jsRqVMNI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QGYlIpj2iKNjXp+AynwawqPxT/g1dQetzxyKkQejqPZaOcuFp22NIl8GLZpLNVXFeLG5goIkrZpXssSm02p72+PYa4IMBvWGXpLeP7JAP01Ijqm1gXxKvv8wRY2TsWHWBP0Yp93+O9peSjyO5L32PeXkH5HKA3UZVyz1eNjgzQA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
Received: from i5e86192c.versanet.de ([94.134.25.44] helo=diego.localnet)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1sZdFk-0002Iu-2c; Thu, 01 Aug 2024 23:22:28 +0200
From: Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
To: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 Sergey Bostandzhyan <jin@mediatomb.cc>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
 Sergey Bostandzhyan <jin@mediatomb.cc>
Subject: Re: [PATCH V2 0/2 RESEND] Add DTS for NanoPi R2S Plus
Date: Thu, 01 Aug 2024 23:22:27 +0200
Message-ID: <7179578.dE46n4Xy2H@diego>
In-Reply-To: <20240801175736.16591-1-jin@mediatomb.cc>
References:
 <22bbec28-41c1-4f36-b776-6e091bf118d9@kernel.org>
 <20240801175736.16591-1-jin@mediatomb.cc>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

Hi Sergey,

Am Donnerstag, 1. August 2024, 19:57:34 CEST schrieb Sergey Bostandzhyan:
> Hi,
> 
> as requested, I am resending the patch series, now with hopefully all
> relevant addresses on To/Cc.
> 
> I noticed, that a DTS for the R2S Plus is not yet available, while the
> R2S is already there. The only difference is, that the Plus version has an
> eMMC, so we can reuse the R2S definitions and only add an eMMC block, which
> I copied from the DTS in the friendlyarm/uboot-rockchip repo.
> 
> I applied the same DTS changes to u-boot and tested u-boot 2024.04 with
> kernel 6.6.35 on an R2S Plus which I have here and the eMMC became visible
> and usable.

general remark, please don't send new versions as threaded replies to old
versions. The normal case for git-send-email is to create a new thread
and this continuing inside the old thread confues tooling.

And it's hard to follow too.

Though hopefully the binding might still get an Ack from the dt-maintainers
so I guess don't resend just now :-)


Thanks
Heiko



