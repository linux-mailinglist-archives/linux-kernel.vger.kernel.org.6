Return-Path: <linux-kernel+bounces-237869-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 987E5923F1C
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jul 2024 15:38:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 554D2282E40
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jul 2024 13:38:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23EBB1BB686;
	Tue,  2 Jul 2024 13:36:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jVci5Ktq"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69A041B4C2C;
	Tue,  2 Jul 2024 13:36:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719927380; cv=none; b=McSDymBmN3Y4tdQGV4e9IAQgvTyi7YYfbuANj61mnhuzUId8EjK9ekF4E/Nu+rciIYM11ZD6tPWgrTa0Eo3M+ZGO6FYv499A/2dV0aWKl0YngjqVWq2lnoaxAVW/AQ9Ey70scEUMrmD89zeVdHrGJ8h+Nd/WGX7zktdo4qnBm60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719927380; c=relaxed/simple;
	bh=44/04iEfSWZJOuq7DzquvfVUDBFC9Eq1hI75oOfnXIs=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=Vlbkv21dNY4uNUMTStzLsP+EHd2NJ9IpbvBY0gYIdBfx1+c2QRxKW5XlPkFWzm3rxDKa8oF5iNZppUgx1AhdRYAM+Ff7KW9eENL8M4qVfVWvKhlRr0JWk8jvS30lKsOXfNIplqxWC2V99/OX6mRa3U2GTpWOtniT7OwI6rGm7a8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jVci5Ktq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 626F3C4AF0D;
	Tue,  2 Jul 2024 13:36:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719927380;
	bh=44/04iEfSWZJOuq7DzquvfVUDBFC9Eq1hI75oOfnXIs=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=jVci5KtqNo3GJS9u7LJbYxh/4jq6YhT4F//kmuRhytaqnhc7EvRekBO1pD/dd3WOh
	 K9jNhs9L/sya9xTFciiZOoCazKFzcX/gkAV6VYR8POvAQgzaLlV6w7pHBWzMBcYsdJ
	 xMY1C17123lRebRssDu9O+VdQgxM9tvh/197nYBprSrDSCnueZNL7FIXTdAV81fGV7
	 8Lg9F/5F9+96m3INFmptqbVTY+MByZQWKKBb9L3knZVjCOrnD5sGJCbFUCMlDdud3q
	 IyKZofoN0zy4Ih9int/zQ+z28TRsTm1hGUWb1mxFtx7Z4XBS14xdMRNgMW72NCAk6p
	 kVfbVFgCjg47A==
From: Vinod Koul <vkoul@kernel.org>
To: kishon@kernel.org, robh@kernel.org, krzk+dt@kernel.org, 
 conor+dt@kernel.org, heiko@sntech.de, sebastian.reichel@collabora.com, 
 andy.yan@rock-chips.com, s.hauer@pengutronix.de, jbx6244@yandex.com, 
 Shresth Prasad <shresthprasad7@gmail.com>
Cc: linux-phy@lists.infradead.org, devicetree@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, 
 linux-kernel@vger.kernel.org, javier.carrasco.cruz@gmail.com, 
 skhan@linuxfoundation.org
In-Reply-To: <20240620212806.3011-2-shresthprasad7@gmail.com>
References: <20240620212806.3011-2-shresthprasad7@gmail.com>
Subject: Re: [PATCH v5] dt-bindings: phy: rockchip-emmc-phy: Convert to
 dtschema
Message-Id: <171992737501.699169.18109328511977115085.b4-ty@kernel.org>
Date: Tue, 02 Jul 2024 19:06:15 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13.0


On Fri, 21 Jun 2024 02:58:07 +0530, Shresth Prasad wrote:
> Convert txt bindings of Rockchip EMMC PHY to dtschema to allow
> for validation.
> 
> 

Applied, thanks!

[1/1] dt-bindings: phy: rockchip-emmc-phy: Convert to dtschema
      commit: e245c725c72f8c94e5fe435fdefd6852851450b5

Best regards,
-- 
Vinod Koul <vkoul@kernel.org>


