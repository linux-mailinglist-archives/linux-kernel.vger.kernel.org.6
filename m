Return-Path: <linux-kernel+bounces-297416-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 294E595B7FC
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 16:07:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C7BF11F22792
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 14:07:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82D311CB330;
	Thu, 22 Aug 2024 14:07:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RMjSrIn5"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C36BB17D354;
	Thu, 22 Aug 2024 14:07:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724335670; cv=none; b=M42swjLJVmiq+bGbmYMA8vzK1N9HYOlxbdAJMUtK7ObTWM/THN7YZsvOHHS5OqNnv+MXAvu6iNwnMg0tptqRQvbgTsJZykm7+IjuSwUq5Qhet6vKGA1ms6fSSz1U6WHITES4Y/4hRbJD18ZXItyCpeQqWR52UEVUYgNpMU9v1LU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724335670; c=relaxed/simple;
	bh=Irho6dWycFCVpBcjEAhgC6mpuQ0Wca6An4qT8hsh9sk=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=uKR3ew+wPx9l61NFwJW5HU33YGW4GYSRgfZgnJ3QCVf+86k1lOYKyki/YzfGmbWYEiKcpVbqkBQwNsaIM7JP3RSCRK25KnTYDqSZRT5kW9jv1CNCD4sSuqQXL14R1NuH42GGYmS3SJ2GjzdOI9GGS2Ncaf0SkyqxLkg2xfPlPmE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RMjSrIn5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62044C32782;
	Thu, 22 Aug 2024 14:07:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724335670;
	bh=Irho6dWycFCVpBcjEAhgC6mpuQ0Wca6An4qT8hsh9sk=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=RMjSrIn5iSJp7U2vmj/4eNxP4N5506s+Ecb20BIsdPq4wiL9Srvxqe2xPCH+CvGU4
	 XBO15qAzbS8/SjoPautpGRMfBDWVP0N6ZXB+G3gZ6StQqymLWLc5QwG8kgy1gC/7G3
	 eRUBypEfnJBaA3SH2932RdSMDYZT5AhTpriwMnymbOrGJA/asB5EgOobdI+2xw5rz0
	 Nbgh/81UwHvcLXnPWIJnXUqndqTDvs5DBuqVtAVc3Yyb/J3FuV6YkFMIJ9/iCY9Izo
	 39OT+AbVg7JC0LHT8uK2vVmaiFKjaPAe0/Fft0PDKhjWIxv66UMmNN7j7JaKHZLL9p
	 0nOaECpDEE4eg==
From: Lee Jones <lee@kernel.org>
To: lee@kernel.org, Tzung-Bi Shih <tzungbi@kernel.org>
Cc: chrome-platform@lists.linux.dev, linux-kernel@vger.kernel.org
In-Reply-To: <20240822121539.4265-1-tzungbi@kernel.org>
References: <20240822121539.4265-1-tzungbi@kernel.org>
Subject: Re: (subset) [PATCH v2] mfd: cros_ec: update module description
Message-Id: <172433566908.1343061.372789251240553871.b4-ty@kernel.org>
Date: Thu, 22 Aug 2024 15:07:49 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.13.0

On Thu, 22 Aug 2024 20:15:39 +0800, Tzung-Bi Shih wrote:
> The module description can be backtracked to commit e7c256fbfb15
> ("platform/chrome: Add Chrome OS EC userspace device interface").
> 
> The description became out-of-date after a bunch of changes.  E.g.:
> - 5668bfdd90cd ("platform/chrome: cros_ec_dev - Register cros-ec sensors").
> - ea01a31b9058 ("cros_ec: Split cros_ec_devs module").
> - 5e0115581bbc ("cros_ec: Move cros_ec_dev module to drivers/mfd").
> 
> [...]

Applied, thanks!

[1/1] mfd: cros_ec: update module description
      commit: 630d7615539ac09a62feb9b1944b04eb65ff3e70

--
Lee Jones [李琼斯]


