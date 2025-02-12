Return-Path: <linux-kernel+bounces-511626-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 93E64A32D6E
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 18:26:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 946CD3AA7A2
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 17:25:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B455D2580D7;
	Wed, 12 Feb 2025 17:24:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I0avArbb"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D119255E42;
	Wed, 12 Feb 2025 17:24:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739381050; cv=none; b=nAMM3ObnTASY97W17Q1uF+SrEdAoWYYVHoEab0fxMAwOj12pssGpyGy2A6JAolhOomPlHHcm7gvHk0AYuS5x8nKLCL5DhW+YmkQOGmBXjaAkxewFeRvfrwIVuXddyKnc/nLS4Le4uLm3PgdhSdwH7xjoe3VdSSZ/sacuzlsJiO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739381050; c=relaxed/simple;
	bh=YfJPNeZAL/Gt0QVU16PpXHr2YpH3wLeO4NQhZ0LMyVg=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=M96LkAR0+TVMRfX4zXS55jds5TAcegdxQS0QL4B9jD6wsHcCtVg5Yhesbd60T7Mvl6dIBFvdUdgyD+m6fihw3z8rne4w/B9H+nHycF6wxWaf/eve8+3LmAHL6VLCdqGvTLPJXBI8uiiYeYoU8kaWaHPj68tnwCAGW3T2MS9PpyE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I0avArbb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 794C9C4CEDF;
	Wed, 12 Feb 2025 17:24:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739381049;
	bh=YfJPNeZAL/Gt0QVU16PpXHr2YpH3wLeO4NQhZ0LMyVg=;
	h=Date:From:To:Cc:Subject:From;
	b=I0avArbbteaS2Lwb7P9TWDjtAt1WkflFYawJO0qimlKC8G4kdj///hsGW5yiSQRCU
	 JLf1tsZjXCO0DMEmNoLlfzfXvdz0ryY5DIYAdeHKJMVBZ8XkzqZ8ak65+usb/KcB8Z
	 U3bKpmsMQnpkIHe6n2lRD+eL/loPeEO/0igptg2ztZe3KS7sDMTkzn7pO6XLjM9jhp
	 mtlW8cX6Y5t5YwKRMstTW6Xtk7XROP6xoa7vv9vf5+TS+b7q8MUU+FAlZw3LwV4ZuQ
	 1wytYUboWc5mKZQ0uyr14pMnQbRa3ruLu0smT1eqBnrBY39c9qdOZOyP7u/yucOLZz
	 h/skKaujX0pFQ==
Date: Wed, 12 Feb 2025 10:24:05 -0700
From: Nathan Chancellor <nathan@kernel.org>
To: llvm@lists.linux.dev, linux-kernel@vger.kernel.org
Cc: conor@kernel.org, ojeda@kernel.org
Subject: Prebuilt LLVM 20.1.0-rc2 uploaded
Message-ID: <20250212172405.GA3066861@ax162>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi all,

I have built and uploaded LLVM 20.1.0-rc2 to
https://mirrors.edge.kernel.org/pub/tools/llvm/.

If there are any issues found, please let us know via email or
https://github.com/ClangBuiltLinux/linux/issues/new, so that we have an
opportunity to get them fixed in main and backported before 20.1.0 final
is released.

Cheers,
Nathan

