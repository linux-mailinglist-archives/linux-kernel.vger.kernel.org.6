Return-Path: <linux-kernel+bounces-223127-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A7FB4910E2F
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 19:14:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5E1201F22408
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 17:14:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F9D31B47B0;
	Thu, 20 Jun 2024 17:13:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iSqHW9y1"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FDB31B3F26;
	Thu, 20 Jun 2024 17:13:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718903614; cv=none; b=Xbq5RJf2xW6Yr6FOj30lGQT8C2vTwCeP4QfkQiJLtVPuBMbd+GcQZZsXV4dsUZlxM2J/2jV3RajiADb/LR2e8P2dSdS96FN51eouZceh1gU+yNL7/LX5Eaj75S7WGu+JSHneuSdKxgmoeH0Ch8APM/3QDZOzZ3YnmgbhS2XnFXI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718903614; c=relaxed/simple;
	bh=c8q5mMs7diG3cJOFetku25MLfNDlZVkMD2Ip49NcFSk=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=FX6qUyjS6WXEoH+4b57RX1Gs8X1WnCrG2ZWThQoarnanQnYhZm52eWA3a3pAfm6lj7NYYNrf3XapttKPZlPunIVmjE8qSL7LJUfP0WVCBzm5+j9LwyJoIUK3NFBuARUYXt6NBC6XbsOoRQTrKnWzvXlEoAcuxMqb+5rZGnyVarA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iSqHW9y1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1AA50C32786;
	Thu, 20 Jun 2024 17:13:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718903613;
	bh=c8q5mMs7diG3cJOFetku25MLfNDlZVkMD2Ip49NcFSk=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=iSqHW9y1SSSuttvbwI1DuFmUvoCR7cevW2LOjTDvi5FTmdxWZ14znrFCuzdOPtNDj
	 z7Wczbcy5CeJZhzer2J9y8iw9jSA820IYd+8gJMz0kRvor8GGWI63XF0RzZAqUaQ5Z
	 S45WANCUyt/sBweXUvYvbRLxwvXc+aATDPx5F/mEznBqEo9uWatfEQ7qy9tR65FkLe
	 GvCkUasAMVQlIysQzbk877zfxFCJ4x71RjY1Qi3dSXibnZtVfeoiF/6tzcmqotypyM
	 umofQpC0WFvZxL2DH82p+TqwC3Cw5TKcfpzWo5cfOjvI6g4kWRMAdKQ/+EuVKhoDGo
	 ci7xCKKRCI+MA==
From: Lee Jones <lee@kernel.org>
To: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas@weissschuh.net>, 
 Pavel Machek <pavel@ucw.cz>, Lee Jones <lee@kernel.org>, 
 Benson Leung <bleung@chromium.org>, Guenter Roeck <groeck@chromium.org>, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Cc: linux-leds@vger.kernel.org, chrome-platform@lists.linux.dev, 
 linux-kernel@vger.kernel.org
In-Reply-To: <20240614-cros_ec-led-review-v1-1-946f2549fac2@weissschuh.net>
References: <20240614-cros_ec-led-review-v1-1-946f2549fac2@weissschuh.net>
Subject: Re: (subset) [PATCH] leds: cros_ec: Implement review comments from
 Lee
Message-Id: <171890361186.1308679.12942645441250151855.b4-ty@kernel.org>
Date: Thu, 20 Jun 2024 18:13:31 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.13.0

On Fri, 14 Jun 2024 12:04:29 +0200, Thomas Weißschuh wrote:
> Implement review comments from Lee as requested in [0] for
> "leds: Add ChromeOS EC driver".
> 
> Changes:
> * Inline DRV_NAME string constant.
> * Use dev_err() instead of dev_warn() to report errors.
> * Rename cros_ec_led_probe_led() to cros_ec_led_probe_one().
> * Make loop variable "int" where they belong.
> * Move "Unknown LED" comment to where it belongs.
> * Register trigger during _probe().
> * Use module_platform_driver() and drop all the custom boilerplate.
> 
> [...]

Applied, thanks!

[1/1] leds: cros_ec: Implement review comments from Lee
      commit: 1b95b0039874092a24f9ee58c8bedf68485221a7

--
Lee Jones [李琼斯]


