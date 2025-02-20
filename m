Return-Path: <linux-kernel+bounces-523939-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 73113A3DD2D
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 15:45:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2A802800321
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 14:39:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90FFB1FCCE9;
	Thu, 20 Feb 2025 14:39:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tcaf+zXt"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1CE41FAC5E
	for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2025 14:39:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740062372; cv=none; b=TusJclk2l5d57QmcOzaEx3azgzUAEESGBdOo5SXwJNZN0K8SbqzvjN4Z8lLGw9GPGMkOOmxvHXXM7frBmb0938kHZ/pXw7O9Sn6g2vs59cG/npr35fEDPhAWCED14JzMsVBQLSxOd3SWxY1MPez0LIBVz8s+ygWt0Nu/FC+O6WM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740062372; c=relaxed/simple;
	bh=vEyLaVHDdR1C24A3uylVTmInW2SohGDRZTXRBJjZQFA=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=kt6XGnChoOvDCKcTh3GsAutgzO84KKAXDK+LRO6KcBZkbuzWmbpghOT4lMYMReSnzxa8HvBNwXdfbvdlWLg8ZRA3hrs1tqMsWOwz4yB9/a7KAX3H9ZbXcKNgPwqH9jSgmTW5FA0GnbOIYh8LIyCPkEbSJviwf4pQy4WAPyAduUE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tcaf+zXt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8B8AC4CED1;
	Thu, 20 Feb 2025 14:39:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740062372;
	bh=vEyLaVHDdR1C24A3uylVTmInW2SohGDRZTXRBJjZQFA=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=tcaf+zXtwZGffuDdqq5c8IDxSOmexCoiWboGzi2PppBSNBnxGSqwOr7StOOIaA6z/
	 KVh1McReelBuZIn6KWIMzy/bgx+RLjdT2Ys1YjnKRe7YFwhkqpn6liQ9pqpCbtxtKR
	 QnRTZrevlpdfcHpxVJObVO5XJ2oCm3Mowx3tYijMgrOnoAMB0mjQf52wnoHCrIGqWo
	 BU8kmnnOdZHq28hK15RoGB1jPCZLoHylqYZ8vcjYZpjXXaNYa6wAY7pDL75YkkqY+5
	 oqKMqasEcgxuzPekQK0e1nG9dfKsFj4irK8QnguZ5LOhuPFYGdueO1QAMVxzaUI5ZV
	 MRxVbo0bRTMVA==
From: Lee Jones <lee@kernel.org>
To: Lee Jones <lee@kernel.org>, 
 =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20250212170403.36619-2-u.kleine-koenig@baylibre.com>
References: <20250212170403.36619-2-u.kleine-koenig@baylibre.com>
Subject: Re: (subset) [PATCH] mfd: lp3943: Drop #include <linux/pwm.h> from
 header
Message-Id: <174006237143.779236.13661749478683671069.b4-ty@kernel.org>
Date: Thu, 20 Feb 2025 14:39:31 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.15-dev-510f9

On Wed, 12 Feb 2025 18:04:03 +0100, Uwe Kleine-König wrote:
> The header doesn't make use of any symbols declared in <linux/pwm.h>.
> There are tree files that #include <mfd/lp3943.h>. Two of them
> (i.e. drivers/gpio/gpio-lp3943.c and drivers/mfd/lp3943.c) also don't
> use any and the third (drivers/pwm/pwm-lp3943.c) has an explicit include
> of <linux/pwm.h> itself.
> 
> So drop the unused include. The intended side effect is that
> drivers/gpio/gpio-lp3943.c and drivers/mfd/lp3943.c stop importing the
> "PWM" module namespace.
> 
> [...]

Applied, thanks!

[1/1] mfd: lp3943: Drop #include <linux/pwm.h> from header
      commit: 5a917e808b56319d977b3062331293136ee1c34c

--
Lee Jones [李琼斯]


