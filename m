Return-Path: <linux-kernel+bounces-559504-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 26DC3A5F4A4
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 13:36:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 61B54173198
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 12:36:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C93B9267393;
	Thu, 13 Mar 2025 12:36:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="phFYyKUU"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32DD2266F1B
	for <linux-kernel@vger.kernel.org>; Thu, 13 Mar 2025 12:36:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741869365; cv=none; b=NvBz07sD5b+eYeH9pFiQ/dBRiHl3yUK5uSGI6RsF2j5ZoQTopQ7UQXef2B+vMynRMheo7LS92nHbDGJDk3/j5GpmMxhJfMw5QRqjaR76+FAdKPrL6zm5pMq1W0OC/z0qAUlzEmPKYzJ5XKKEV8Q360SDMe0iKIT7uvJnFQ/Q5wI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741869365; c=relaxed/simple;
	bh=ExXY6AL45vxP8X4XDgr390U/+EulvSnEOgFDIP9X6zw=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=r4aso7zll09H5k2qSW4PayZ37FRm8uP8hXw82UDvOQjRcppjWwRgiFWJVRPCnOmAv3p6+dvCIjSghVZ9wDJS4zQV5een3uwqnD7a1HT0NEoz5IBiQs9kDzjL/3Ekee9B625ALgt5y8PV7yr+6QW28FvOMT1NycKfHmJSC8DG8zY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=phFYyKUU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61374C4CEDD;
	Thu, 13 Mar 2025 12:36:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741869365;
	bh=ExXY6AL45vxP8X4XDgr390U/+EulvSnEOgFDIP9X6zw=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=phFYyKUUxvu0FZN4uHqgnx+XziwagzLuMdUOXeMBd0JCOcPEOAELpyDt7VeW5TJip
	 OcvR5FlMckw05htkPI32lIlVSqyqvX2wuAaQUo6KP8+JCWT8cYbhxQcW+Dk1Ho28dj
	 K0u8J+/FreQB4debVUVWsw7lSVUqUFVfwMJn/itDizcM4CJf4DhsEDuCpQOzlNNRuQ
	 prBScf65elNNJRzMvKJJq+rWTwCrz6lwwEoK90Z8AGi575OQERsb+OsnnGs0inVhmU
	 magHKYGeRDAyt0TIoVt4j/seIwebhwaHX24NlNm7WteT4Mu+0LHSw1Yqr2S2cRQpaT
	 bR2STchLDTBog==
From: Lee Jones <lee@kernel.org>
To: Lee Jones <lee@kernel.org>, Aaron Kling <webgeek1234@gmail.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20250228-max77620-module-v2-1-eb686216437c@gmail.com>
References: <20250228-max77620-module-v2-1-eb686216437c@gmail.com>
Subject: Re: (subset) [PATCH v2] mfd: max77620: Allow building as a module
Message-Id: <174186936414.3607024.14008739699568475990.b4-ty@kernel.org>
Date: Thu, 13 Mar 2025 12:36:04 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.15-dev-510f9

On Fri, 28 Feb 2025 09:24:26 -0600, Aaron Kling wrote:
> The driver works fine as a module, so allowing building as such.
> 
> 

Applied, thanks!

[1/1] mfd: max77620: Allow building as a module
      commit: 13cefded0104ee24494fb8cff90ae3e4485d74cc

--
Lee Jones [李琼斯]


