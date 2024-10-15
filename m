Return-Path: <linux-kernel+bounces-365898-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DC1199EDB3
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 15:34:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4F7511C21701
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 13:34:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A35AB1386D1;
	Tue, 15 Oct 2024 13:34:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L0X4/WtO"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 135B81FC7CA
	for <linux-kernel@vger.kernel.org>; Tue, 15 Oct 2024 13:34:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728999256; cv=none; b=qjubD6InqTwzueC93d1/hfGJs28TQhpnGgJh3GdD4L1OuOPxmxSKnyWznO5fLdixDrNo3b91sJehYQdfry4ozUGp5cc/JVx7C7IgVJ/IyNj8qnOhwMd9FeOjjloxBEaMPrlcA5I2zE6lBQJpgMEOYrzqctB77q9v8hHvQXcSFIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728999256; c=relaxed/simple;
	bh=noUj4JNTHcQ4H21CQH/Qr3D06XAnQ71sjLHi5JGlLTs=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=Y/er0dMgr3zCL+qxQ32Inj0XI6uNrKG9lZFzfIkKeoAFIz7Iw1GcHaGCmHn3V/ItVyWFCzgM9RCJk0r7ewyaI/4/f3esqjwwLWyB0DrXFYPyQ1N+yIwT9fhT5y+MWn+VDrdHIv+OaLcvzFLtL3Q94LNBNYzstuavIpbriIyQZmM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L0X4/WtO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87CA5C4CEC6;
	Tue, 15 Oct 2024 13:34:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728999255;
	bh=noUj4JNTHcQ4H21CQH/Qr3D06XAnQ71sjLHi5JGlLTs=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=L0X4/WtOc3fB7EvVoCmQzgqIoD6lI9YOGdt1Ij5VWPfkbVZJAcNI3Gc6KaDWopOJP
	 skHzGJNnTqXKZ05/gQt/wwGYfyMKSVhwoTlAzNwmHXy1qOHSuSdvQ06J+kLgpnbpGe
	 MdL7HQm1DaZtSNOwM4OCyFxZ7OHoPZB/UZYYIMu2al2IVm7pwZasDAztkAd6JUcUEX
	 QOS2OOqK/Mt4fKsN3/5p7vIKkBr2FJr3P/FbUhtcZWa+5JMP/ihoXYNEsDC4ewsj9u
	 zYBn44IeOO+WWAdBkTvFFzN8YNPNkX2C3fE//SLm0TrAwqnpr2m3sASfmA6JK7fYfa
	 Cro6D98kcpZng==
From: Lee Jones <lee@kernel.org>
To: Matti Vaittinen <mazziesaccount@gmail.com>, 
 Matti Vaittinen <mazziesaccount@gmail.com>
Cc: Lee Jones <lee@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, 
 Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org
In-Reply-To: <dda4464443fba81f79d5f8d73947dbd63083cff2.1727931468.git.mazziesaccount@gmail.com>
References: <cover.1727931468.git.mazziesaccount@gmail.com>
 <dda4464443fba81f79d5f8d73947dbd63083cff2.1727931468.git.mazziesaccount@gmail.com>
Subject: Re: (subset) [PATCH v2 1/2] mfd: bd96801: Add ERRB IRQ
Message-Id: <172899925429.582805.1098830920671719671.b4-ty@kernel.org>
Date: Tue, 15 Oct 2024 14:34:14 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.13.0

On Thu, 03 Oct 2024 08:34:38 +0300, Matti Vaittinen wrote:
> The ROHM BD96801 "scalable PMIC" provides two physical IRQs. The ERRB
> handling can in many cases be omitted because it is used to inform fatal
> IRQs, which usually kill the power from the SOC.
> 
> There may however be use-cases where the SOC has a 'back-up' emergency
> power source which allows some very short time of operation to try to
> gracefully shut down sensitive hardware. Furthermore, it is possible the
> processor controlling the PMIC is not powered by the PMIC. In such cases
> handling the ERRB IRQs may be beneficial.
> 
> [...]

Applied, thanks!

[1/2] mfd: bd96801: Add ERRB IRQ
      commit: 44ce4f769494ff4777ae0dcb1f81363c887a6f7e

--
Lee Jones [李琼斯]


