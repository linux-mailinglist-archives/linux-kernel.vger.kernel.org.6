Return-Path: <linux-kernel+bounces-404359-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A55299C42DE
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2024 17:43:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6F7C8B25E13
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2024 16:42:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3B191A254E;
	Mon, 11 Nov 2024 16:42:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JJ1qYURT"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31D8B189BBF
	for <linux-kernel@vger.kernel.org>; Mon, 11 Nov 2024 16:42:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731343339; cv=none; b=aIqej/0pHz9pUdgdckgQQGKpaj+H4/7ithHNoVQigPNPb2OknA6AVblbg4BH6bTlHmfk9O7JX+aMcxkgYOhYZRzpnOwiu9+Ixbh2UB/I0/QZXeYwN9To9XMEt0AmdhVssgqMAiFycrs1olTv7BhNHQIzKKAhtkwJP7Atr+I6sF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731343339; c=relaxed/simple;
	bh=bMvBiLBnkjt3874HBhx/ZepwiWrsNm8t1pyp0Dzw9vM=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=Fcj2TCx/7QnSThaiRq/WRHdVplqiw0erWiObDkIFhmd3o8cTXIViRNSWa/Fxe6q21QfynbUelXzp6IAHT47hcqsl1zuvFVBYpXXmxZRL8157U+IthGaicVhbYA90U+GOYx2IL0wVmPnue1skd0Kp6sbL9FqYtOW/IL09OOhzWPg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JJ1qYURT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D992C4CECF;
	Mon, 11 Nov 2024 16:42:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731343338;
	bh=bMvBiLBnkjt3874HBhx/ZepwiWrsNm8t1pyp0Dzw9vM=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=JJ1qYURT4/USA0qQ9SPzD1Jr6mPgThmCVBYRsVQkC+T8zvX2AEVJQB5XzdYoC1XFG
	 I+Dv8zHL06ZiptgznmMxJ3AnB816j262Q2rkV1CpixB3zpyg30iyHVZVlXAe7wmmJ7
	 S38ixJcz8/lJq1/I0KakQD+WUAQ64bfs4CenYVbmiPl33VLjWN8qxgfRx9gsR5bjkE
	 egwiaXIwMM0ap9ZBXNNHfrPdhhRFwSwa3GOnxPwLuIjeNy+Vg8jJhmP3hmYDtbL1k9
	 /ZoLUzZXT6R/ldYELGUut2hsxctZp0s+tpzfAJfbiinTydLaZ5TLkW0Ocq1kedle+T
	 +TVDiRXNCWMxQ==
From: Lee Jones <lee@kernel.org>
To: Lee Jones <lee@kernel.org>, Daniel Thompson <danielt@kernel.org>, 
 Daniel Thompson <daniel.thompson@linaro.org>
Cc: Jingoo Han <jingoohan1@gmail.com>, 
 Jason Wessel <jason.wessel@windriver.com>, 
 Douglas Anderson <dianders@chromium.org>, dri-devel@lists.freedesktop.org, 
 kgdb-bugreport@lists.sourceforge.net, linux-kernel@vger.kernel.org
In-Reply-To: <20241108-new-maintainer-address-2-v1-1-47c9d71aac11@linaro.org>
References: <20241108-new-maintainer-address-2-v1-0-47c9d71aac11@linaro.org>
 <20241108-new-maintainer-address-2-v1-1-47c9d71aac11@linaro.org>
Subject: Re: (subset) [PATCH 1/2] MAINTAINERS: Use Daniel Thompson's korg
 address for backlight work
Message-Id: <173134333678.299614.17079258343612609351.b4-ty@kernel.org>
Date: Mon, 11 Nov 2024 16:42:16 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.13.0

On Fri, 08 Nov 2024 08:30:44 +0000, Daniel Thompson wrote:
> Going forward, I'll be using my kernel.org address for upstream work.
> 
> 

Applied, thanks!

[1/2] MAINTAINERS: Use Daniel Thompson's korg address for backlight work
      commit: 3adec6f907b698b32ab62f70da31b41abed00c59

--
Lee Jones [李琼斯]


