Return-Path: <linux-kernel+bounces-295780-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D018095A16B
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 17:31:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8BF78283D54
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 15:31:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06FA914B948;
	Wed, 21 Aug 2024 15:31:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aQn7mTu4"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 503ED14831C
	for <linux-kernel@vger.kernel.org>; Wed, 21 Aug 2024 15:31:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724254265; cv=none; b=Y6UtJ30AiwIgvtRYAzj75NeTM3IXQp+TY5nbZy8EPc4ncKaguFNe7lc4j0N1x4DGiXicllJqcNtYmwRoA0LH4uufa2CxovAplmwUcjPKzb90ihbFHWhdtN2WNYj6B/uxH0/szoejFnlsMe8n8arMJ33KQNlOjmlRakuRS7Lv9xY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724254265; c=relaxed/simple;
	bh=gnwn+Az7wzgwX58lMi3e3c9b5h1hVOgScvEruijfLrM=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=J3n5JQJLLZSGLsVZXHtYNXhHSIWvc/j7BC/YJGCycnZeNXdWCfe4FubYBUWNsiQxT8cU+QfpZtfAefwn+BjdY73/mTu6LpUMndgPX24y6t9uIZYrqNAkNoA7BFqNJwN0343g5TdzltOfvFq/TjSga1diww2boPWuVLezVyF1H/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aQn7mTu4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4903DC32781;
	Wed, 21 Aug 2024 15:31:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724254264;
	bh=gnwn+Az7wzgwX58lMi3e3c9b5h1hVOgScvEruijfLrM=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=aQn7mTu4SlJKPdNyaaXDnW1W5SLBg2q4hLHaWO8QHJ7Xx/FK5AFL4ed4QPLTTPcn1
	 MX+UAmaBBjdLVYs6uR3mZK/RGW1voj6xqfjZX+Thj0rQw7Qi5rk0GbpDccgimOAgz+
	 wtDNqBHEXICfYvBNbXDu7imGdy1gGbz+BDk8WO0qrAogj84nq3PjfCklF/iHTIeafs
	 z4eycL2S+Micht2OEhGN0J0y1ZWMM25i17sdJVcLkmD2M7tRddA4HfL+oz8y0rAW2Q
	 S5bqhP3FRkt6XaikIFHxucMotTKcqOOyk9D+WJ1lALchBNngpOZA0z5ajj6Y8SFE6T
	 A2l+vGCFTKKpw==
From: Lee Jones <lee@kernel.org>
To: linux-kernel@vger.kernel.org, 
 Detlev Casanova <detlev.casanova@collabora.com>
Cc: Lee Jones <lee@kernel.org>
In-Reply-To: <20240802134736.283851-1-detlev.casanova@collabora.com>
References: <20240802134736.283851-1-detlev.casanova@collabora.com>
Subject: Re: (subset) [PATCH] mfd: rk8xx: Add support for rk806 on i2c bus
Message-Id: <172425426403.1030290.447306304625489078.b4-ty@kernel.org>
Date: Wed, 21 Aug 2024 16:31:04 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.13.0

On Fri, 02 Aug 2024 09:47:36 -0400, Detlev Casanova wrote:
> The ArmSoM Sige 5 board connects the rk806 PMIC on an i2c bus.
> 
> 

Applied, thanks!

[1/1] mfd: rk8xx: Add support for rk806 on i2c bus
      commit: 2dc90423dd5c1b7df569555a5bfdf81634982c05

--
Lee Jones [李琼斯]


