Return-Path: <linux-kernel+bounces-258067-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5408D9382E4
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Jul 2024 23:11:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DD668B217EE
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Jul 2024 21:11:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F58D14900B;
	Sat, 20 Jul 2024 21:11:08 +0000 (UTC)
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D11D0148FF3
	for <linux-kernel@vger.kernel.org>; Sat, 20 Jul 2024 21:11:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721509868; cv=none; b=iFukWyhRqIro+1qmvN0B+LemmNtBeedpdmGDPrJ3yxZr/pWo6Iw4nqrKvC+PzzsIcPk5wMaX8cUY9Mwus2ekiD3h1Vj2c0GNYCvFrbJsPeohOrreOvompX6WmKqLsJeY26+pWaGdzY+XZJKR+UdlgBd3XMSyDgaMBEG43xcasXw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721509868; c=relaxed/simple;
	bh=4ZbBgFtkpb8Z8G/xCPxDcI4UfibxO4YK5IoJd7/+cBY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BYdf9fIqkkEFVIr3rxhYKvugG/Tb27DdYw/9gVukvhnD60/xNJZpiMzyHXd1nIKlZmuk58Zu+s3hSHjUhCZ4dCaKZA8eGT4gRHD53FNrAaEyUyHUEHt/7fnJLNZYxvcPfNPdF8NzVyKCh5lp0Pkxyve+H6JbE7pDnK2txKieKC0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
Received: from i5e860cd3.versanet.de ([94.134.12.211] helo=diego.localnet)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1sVHM5-00065w-Li; Sat, 20 Jul 2024 23:11:01 +0200
From: Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
To: linux-rockchip@lists.infradead.org
Cc: ukleinek@debian.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/8] arm64: dts: rockchip: enable uart0 on qnap ts433
Date: Sat, 20 Jul 2024 23:11:01 +0200
Message-ID: <4879096.JsnAkG3lO3@diego>
In-Reply-To: <20240720210856.778014-4-heiko@sntech.de>
References:
 <20240720210856.778014-1-heiko@sntech.de>
 <20240720210856.778014-4-heiko@sntech.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

Am Samstag, 20. Juli 2024, 23:08:49 CEST schrieb Heiko Stuebner:
> Uart0 is connected to an MCU on the board that handles system control
> like the fan-speed. So far no driver for it is available though.
> 
> Signed-off-by: Heiko Stuebner <heiko@sntech.de>

ignore this one ;-)

I updated the subject and them fumbled with git-format-patch



