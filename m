Return-Path: <linux-kernel+bounces-571168-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EC35DA6B9F4
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 12:34:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6CE487A799C
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 11:33:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D197A224256;
	Fri, 21 Mar 2025 11:34:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F+OXKiG1"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 327B222370A
	for <linux-kernel@vger.kernel.org>; Fri, 21 Mar 2025 11:34:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742556857; cv=none; b=k9YdWcLu0Ftb1mbTabATPz4nA3f/UvpEWuzarjslP9aYSMRv9fj9TDnyBZFEzGBmu4kzT5U8+uoomFBF23NtSR9ou/AYxhzMxQEStcSGCwtV75XVIjzbVdlWrXshkKkxi+jy02Fx/v1W4fVTlyjE/Tlr4yUjhri/RLFU0alEBOs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742556857; c=relaxed/simple;
	bh=ghbXk6xdG0NIwvUebm124UcaF2mhL8bEq8EOiqpfvFc=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=ohWvBHx/y2rdzmyazH2vUceVdtw2VJW28Y3bYmUzk0GBcpzrtoo4RfK5t72frly/3ihJkLS5SFE16X+xOSyOoyZpniQGlGcUG2s1T0k94R38aGfhzcYf+WWuc2Bm6xMJqZG9+IOpnJ7tF75WAVvIZpIv/zsee9K6qyQLRVhJKzo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F+OXKiG1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18557C4CEE3;
	Fri, 21 Mar 2025 11:34:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742556857;
	bh=ghbXk6xdG0NIwvUebm124UcaF2mhL8bEq8EOiqpfvFc=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=F+OXKiG1fCKHGYc4AA5gCsENfKCUg5dgy/i2IyCq3bVVdF2Yk8IrkkdnBce+lAMVL
	 LxE+iNSAo8OqHAYhgC3tpNQsS2Pyq30LuYOGt8UgLehbs2wGOLN4dR5hjMsP4hQKg+
	 0S/Xw6cG46SkxCa8UFqH7yUVyVKl7/6ZPM0++kCbhLdSOhlyz6fqK8+jX3y5RRPfuT
	 CRdIX37GSYmQ13jyAm8Q/dRKaa+wA3nTAkriFzv7BpCSxTm6F9BTAFW9dod8kVlkWL
	 z9tYr+NbcSZfuXGZ84G0ND+LF6YcqklhrxGe47p9px3I1ZU2Y+0178O2XTqETL2Dw0
	 +YnAmpz8THYBw==
From: Lee Jones <lee@kernel.org>
To: Lee Jones <lee@kernel.org>, Thomas Richard <thomas.richard@bootlin.com>
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 blake.vermeer@keysight.com, linux-kernel@vger.kernel.org
In-Reply-To: <20250318-b4-cgbc-sa8-support-v1-1-6ae9ec443c05@bootlin.com>
References: <20250318-b4-cgbc-sa8-support-v1-1-6ae9ec443c05@bootlin.com>
Subject: Re: (subset) [PATCH] mfd: cgbc-core: Add support for conga-SA8
Message-Id: <174255685582.2093466.14966317418769581223.b4-ty@kernel.org>
Date: Fri, 21 Mar 2025 11:34:15 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.15-dev-510f9

On Tue, 18 Mar 2025 11:36:52 +0100, Thomas Richard wrote:
> Add Board Controller support for the conga-SA8 module.
> 
> 

Applied, thanks!

[1/1] mfd: cgbc-core: Add support for conga-SA8
      commit: a8d1376568619d5b7fb867929b01eeaa59bb9097

--
Lee Jones [李琼斯]


