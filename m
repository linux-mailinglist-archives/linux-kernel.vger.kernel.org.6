Return-Path: <linux-kernel+bounces-196974-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D58E38D647F
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2024 16:26:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 122D81C23AEC
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2024 14:26:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EE9643AAB;
	Fri, 31 May 2024 14:26:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NSdKK3YB"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5776A3F8C7
	for <linux-kernel@vger.kernel.org>; Fri, 31 May 2024 14:26:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717165587; cv=none; b=YGi1lvTPH9I/bUg+CQy25VPSdf0aBKDR+RJm6THwxMm44zmSJqvjBdnf/pfubz5fxNjdV/UYrcjr83NrcqcVnXkB0gLO7EPCreb/Qz9EbmQYVEisOW7lyaLWOgpqxFtiAZdP66FdL0OUvxfwWj+c1vftyaKAswzJc/a/ulxxWHI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717165587; c=relaxed/simple;
	bh=GZFJrm2kqf6maTG4GijP+HJf/ay9Ol6Ekosfa0A0NP0=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=exgpx6ORzgzbSCQVRyL8qv9CCX0gppkRJntjFBDNPl+u6DUuOGby8ebjYeglIDiZHVMOasCn91/GJ8GPbQzZxLdHg3qLkiBqlEWx3dMVAQDEdk6lQPZKNK8nU9MhzjLISvxaYe5l9PBf6SY7EM7zEjMxqWhPBjcXVmJx4WWRrqs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NSdKK3YB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7E0BC116B1;
	Fri, 31 May 2024 14:26:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717165586;
	bh=GZFJrm2kqf6maTG4GijP+HJf/ay9Ol6Ekosfa0A0NP0=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=NSdKK3YBpFc2QR3/BgTkh+lBOAK8py8uVblGzezvJ7+uAuFaazrkpZ6p2mrdpOYMg
	 mHQ+Zo3g0e6mled6aIQEbJCyCmGKkb8PnjkHOFrBMqqklSGS5tzz16keaWQeq1pRYI
	 Rk5MbJ7AtX+va8DT1TSiG3tt/p4GhraLVFVSLtHN0HZJjkIFqWti91yBgAXKVMocje
	 Um48g8ugRxicF1WGWHdVaPr8eA5NTgmIBZUYwG3fSE1iykvmV1HFGiSybTXeS2qo+7
	 tjWncux0bfOCg/g+VlIeO0d6U6ZFsw+7sJ716WMrqjIJXa0NmQ8qal22s5EGLr1/FM
	 hUepQmI9aw+fQ==
From: Lee Jones <lee@kernel.org>
To: Andy Shevchenko <andy@kernel.org>, Lee Jones <lee@kernel.org>, 
 Hans de Goede <hdegoede@redhat.com>
Cc: Jani Nikula <jani.nikula@intel.com>, linux-kernel@vger.kernel.org
In-Reply-To: <20240527114950.326659-1-hdegoede@redhat.com>
References: <20240527114950.326659-1-hdegoede@redhat.com>
Subject: Re: (subset) [PATCH v2] mfd: intel_soc_pmic_crc: Use
 PWM_LOOKUP_WITH_MODULE() for the PWM lookup
Message-Id: <171716558569.1130342.10997677868136938619.b4-ty@kernel.org>
Date: Fri, 31 May 2024 15:26:25 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.12.4

On Mon, 27 May 2024 13:49:50 +0200, Hans de Goede wrote:
> The primary use of the CRC PMIC's PWM is for LCD panel backlight
> control by the i915 driver.
> 
> Due to its complexity the probe() function of the i915 driver does not
> support -EPROBE_DEFER handling. So far the pwm-crc driver must be built
> into the kernel to ensure that the pwm_get() done by the i915 driver
> succeeds at once (rather then returning -EPROBE_DEFER).
> 
> [...]

Applied, thanks!

[1/1] mfd: intel_soc_pmic_crc: Use PWM_LOOKUP_WITH_MODULE() for the PWM lookup
      commit: bf4bf08ec1142a532bcc73dfc4960cd676c3978c

--
Lee Jones [李琼斯]


