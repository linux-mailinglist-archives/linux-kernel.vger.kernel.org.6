Return-Path: <linux-kernel+bounces-244471-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D4F2D92A4A8
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jul 2024 16:28:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 91186281646
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jul 2024 14:28:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABA5E13E3E7;
	Mon,  8 Jul 2024 14:28:38 +0000 (UTC)
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5996513E051;
	Mon,  8 Jul 2024 14:28:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720448918; cv=none; b=OfRgZLB3rm+RCbaCO8+7iHMM7TilZmwtj0XJmLz45XUgxqtW5jMck4a5/FU7+pxWd0u19XEyP9oSA/J0oKJcg6u2pFSpmr9H68Fd4XHQow0M4r1jvbR6BkQg18qq5/1gD7DHsUG4sSgrZfAQIhnN63oeIx9wvshBssMnJjui+Iw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720448918; c=relaxed/simple;
	bh=8BQvqTe+Lh/cGTkCkdUl8vH2AUJu6VaQ1ewVVZKJSWE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ISK+8u77M1pdngtAR7tVZRpVJZc+U1LOWoBc/aOADi7B9KcVNBTa5aWU0rknjYTHNxN1T0ZtfIcOTFwTqYHUb47hExwG8o6Et8uwdOW6UL1wZft60VplL9u1HsQaqT/yTEyelwi4RtyUFNVlx2i7pfhJKo3f6/JshUbFAvB9BZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
Received: from i5e8616d7.versanet.de ([94.134.22.215] helo=phil.lan)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1sQpLa-0001Jx-Oe; Mon, 08 Jul 2024 16:28:06 +0200
From: Heiko Stuebner <heiko@sntech.de>
To: Diederik de Haas <didi.debian@cknow.org>
Cc: Heiko Stuebner <heiko@sntech.de>,
	linux-rockchip@lists.infradead.org,
	Furkan Kardame <f.kardame@manjaro.org>,
	Shengyu Qu <wiagn233@outlook.com>,
	Andy Yan <andyshrk@163.com>,
	Jagan Teki <jagan@amarulasolutions.com>,
	devicetree@vger.kernel.org,
	Dragan Simic <dsimic@manjaro.org>,
	Michael Riesch <michael.riesch@wolfvision.net>,
	Chukun Pan <amadeus@jmu.edu.cn>,
	linux-arm-kernel@lists.infradead.org,
	Maximilian Weigand <mweigand@mweigand.net>,
	Chris Morgan <macromorgan@hotmail.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: dts: rockchip: Add dma-names to uart1 on Pine64 rk3566 devices
Date: Mon,  8 Jul 2024 16:28:03 +0200
Message-Id: <172044883546.1350787.6142628097865856135.b4-ty@sntech.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240705163004.29678-4-didi.debian@cknow.org>
References: <20240705163004.29678-2-didi.debian@cknow.org> <20240705163004.29678-4-didi.debian@cknow.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Fri, 5 Jul 2024 18:22:14 +0200, Diederik de Haas wrote:
> Similar to bf6f26deb0e8 ("arm64: dts: rockchip: Add dma-names to uart1
> on quartz64-b") also add the dma-names property to the other rk3566
> devices from Pine64 with bluetooth functionality.
> 
> 

Applied, thanks!

[1/1] arm64: dts: rockchip: Add dma-names to uart1 on Pine64 rk3566 devices
      commit: 3087576e1c706bcd3623b48478ea8c9b23173107

Best regards,
-- 
Heiko Stuebner <heiko@sntech.de>

