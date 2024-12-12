Return-Path: <linux-kernel+bounces-443687-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DDF779EFAAC
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 19:20:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6843E169F64
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 18:17:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E58B22E9E3;
	Thu, 12 Dec 2024 18:09:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="u1+tRiB/"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C9CF22C37C
	for <linux-kernel@vger.kernel.org>; Thu, 12 Dec 2024 18:09:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734026973; cv=none; b=ni8FldnEUTafCSlCmUJA1MYYQL9zQxsb7qY3U1HWmkV7jO2GCaufDPgHZJcdSo5V0wsa89IwzAAYjmYlxr+d37PXQ+j4WYG8FgIYTNgdbH7IUcdFlh/Vd6D4Pke9/hFrNoZaRamKU4aFEMe5aT05ZoJIZTEEZw2IciDXgmpnz9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734026973; c=relaxed/simple;
	bh=W4Scnv8dXsNwwPUlS+IQ/wDy0xYTvphokl9mOs8/VxA=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=ZAyKEEXT3XsCYmYzlcwqGVRnE5hZQsMsW9Feqg8Q3clJ5LjkUssXzU9Okg9gaCmYQgepbL7YBxTG58hqR6bLzL3AM0MEfwsBNqdVCfA7il9cznK+RyGgBhEPytlHhqCO6RcO69uqG7a8UyORbo4qd7T+NOt+JSwMQlxck0jq18Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=u1+tRiB/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0FD53C4CECE;
	Thu, 12 Dec 2024 18:09:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734026973;
	bh=W4Scnv8dXsNwwPUlS+IQ/wDy0xYTvphokl9mOs8/VxA=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=u1+tRiB/dq+kclFj7W1Atg098rdmTrV+uZ6NoBhWJeuZ178EejRtO5sUSZ+S1uDH4
	 ZrfWTLe9XqRFnRtpnwU3BrjPWIkA1ywyEMrFJN6YOe9fyGkSmRFk4o3NYb2f201O3J
	 pQZyi+M5o/K+Brd0O1lSbv6sM9FhafZpVRMasKanxHsdA7sBsHq1WDLyPuaeHbsKPa
	 BZGZQCsvM/3TYIo1gnHwvsOK0ZRL+ljJFWAOUcA91jWAcRecxV/yaKoXtpwQAw8SiR
	 RaH3PcVwJtkPpfYjREzUal3PJjVeE0S4BndcGPZQcPyda2lHx3kLGtugxvBBxx/0vo
	 YAeREbvgI9fBw==
From: Lee Jones <lee@kernel.org>
To: lee@kernel.org, Charles Keepax <ckeepax@opensource.cirrus.com>
Cc: yung-chuan.liao@linux.intel.com, peter.ujfalusi@linux.intel.com, 
 linux-kernel@vger.kernel.org, patches@opensource.cirrus.com
In-Reply-To: <20241205115822.2371719-1-ckeepax@opensource.cirrus.com>
References: <20241205115822.2371719-1-ckeepax@opensource.cirrus.com>
Subject: Re: [PATCH RESEND 1/4] mfd: cs42l43: Prepare support for updated
 bios patch
Message-Id: <173402697177.2318075.9922530915478047926.b4-ty@kernel.org>
Date: Thu, 12 Dec 2024 18:09:31 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.13.0

On Thu, 05 Dec 2024 11:58:19 +0000, Charles Keepax wrote:
> Newer bios patch firmware versions now require use of the shadow register
> interface, which was previously only required by the full firmware, update
> the check accordingly.
> 
> 

Applied, thanks!

[1/4] mfd: cs42l43: Prepare support for updated bios patch
      commit: 049d5ca76637d305650e68332ecf5cfb18d74b0b
[2/4] mfd: cs42l43: Use gpiod_set_raw for GPIO operations
      commit: 5fb65a3749286b8fb1c8c0b1ccc6ed7caedf3632
[3/4] mfd: cs42l43: Increase the SoundWire attach timeout
      commit: 7c28a3909ccd45ab4d560ef1e57fbc0890fbf6e9
[4/4] mfd: cs42l43: Use devres for remove as well
      commit: c5bb88eac10f5a69b2c281edaed39f25e096e43a

--
Lee Jones [李琼斯]


