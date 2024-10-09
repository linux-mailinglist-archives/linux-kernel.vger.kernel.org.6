Return-Path: <linux-kernel+bounces-357131-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BE7FE996BE8
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 15:31:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 84CB42822A1
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 13:31:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 919111990AD;
	Wed,  9 Oct 2024 13:31:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n9Vosui+"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00FEA198A34
	for <linux-kernel@vger.kernel.org>; Wed,  9 Oct 2024 13:31:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728480687; cv=none; b=lwkTac/+wMozy2r4MnoIYSKojPpTqCNImg/6cVyb7NOia3KM+E5WEQdp5D8PeN3ke6D1AD46baZeUNKpr513qWRTIIfmK4ud05bpp9e/pbgIPW7KRKZMO32c0qEJxMR+BZ6VosnWWWv0c20uq0gVL3CnnGnz82908iiSso5As+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728480687; c=relaxed/simple;
	bh=vehBi9HrzNpnOMTgh3ezhlocnC8hnbEqSNqQ+2W0hRk=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=YmEWo+mNdiA42/DV8P66ECMZoNHxEzjZe9bhAzwhhdWObxJ+V2SBZ6JfA7lHRFZhc0rpgJE5kyVn9ACzJQeF7qjenZMttE+u5XAgy7QzAw72VeGa4pLaUsO5DQKSlYEvbNt00N+G2M7glb6SgEp6olX8XHLVmleJba2gElZ4F18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n9Vosui+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39E58C4CECE;
	Wed,  9 Oct 2024 13:31:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728480686;
	bh=vehBi9HrzNpnOMTgh3ezhlocnC8hnbEqSNqQ+2W0hRk=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=n9Vosui+tC2mjcCpuO/dLPZfymsBARXfAUrMmfK9qsBTrSfdva2Rha3/xEyiRbzzr
	 eAOEKBTmOdqWgA4D5c/nkuR9vg0AVAe+Kcy0Hps8PSgo7IpjbXtgXzD3/kKls2NYT/
	 Wxs1nLjEwiIocLU6DrawKP+kgWcwgND+RUrEhXX9IiGwqg3xf8kmOLLSHThrANN6Xm
	 kjiOu7iRqX/hiOC2IDLYpHJlSpiZs1iBJ/dU99IiZz6v8sDkMWVgydB9zMYHKhBY8D
	 S0qDIf9SAc6+iJ6KMsXywqYxA5KMwv/4Rg2fDnNNdlvVFNj8wrOrUNfhw4CL3cAIS8
	 9ZGd/daUpEiLg==
From: Lee Jones <lee@kernel.org>
To: Support Opensource <support.opensource@diasemi.com>, 
 Lee Jones <lee@kernel.org>, Axel Lin <axel.lin@ingics.com>, 
 Adam Thomson <Adam.Thomson.Opensource@diasemi.com>, 
 Marcus Folkesson <marcus.folkesson@gmail.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20240925-da9052-v2-1-f243e4505b07@gmail.com>
References: <20240925-da9052-v2-1-f243e4505b07@gmail.com>
Subject: Re: (subset) [PATCH v2] mfd: da9052-spi: change read-mask to
 write-mask
Message-Id: <172848068494.547566.18147572895847240366.b4-ty@kernel.org>
Date: Wed, 09 Oct 2024 14:31:24 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.13.0

On Wed, 25 Sep 2024 12:19:53 +0200, Marcus Folkesson wrote:
> Driver has mixed up the R/W bit.
> The LSB bit is set on write rather than read.
> Change it to avoid nasty things to happen.
> 
> 

Applied, thanks!

[1/1] mfd: da9052-spi: change read-mask to write-mask
      commit: f77c2e93771be2d66c639c8eb0b463de2c321579

--
Lee Jones [李琼斯]


