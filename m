Return-Path: <linux-kernel+bounces-436506-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A9DBF9E86DF
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Dec 2024 18:03:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A24171642B7
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Dec 2024 17:03:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E287191F74;
	Sun,  8 Dec 2024 17:03:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gdHZaAoS"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E114E1885BF
	for <linux-kernel@vger.kernel.org>; Sun,  8 Dec 2024 17:03:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733677392; cv=none; b=E2Vx2RKGpDnfzMU6Z0NtOTDAB1f7uN8KfYVoBfnEq829O3WnlhCgtRycEwUokALWQSFXjDJEE4wRgTh4OdF/fwHMSyw3ZiIIGBf0WAFfYTsD+ve9VBnMPLaYPrwQkawuLDP/y/hrgoX8el2dUcW4efVh1O4+A3TJckKwnMXwVe8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733677392; c=relaxed/simple;
	bh=Lnz2aWDHGkRniarfLIMsg+D6EF3yAhHrAHetguznFNg=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=QwasyuGGFH9FFwUk30CZyDN8rXYe5lPv7MCRAMa7P7FsnNIsUTA8ImdXGADQAI1d2USpg/UqvnASclmpQH9MVy/EW1nQccQwbD+5JvrGTVg3VbOczSDT6opZTlB/wDkgutnXEyO4BQybubk5/t4ydg2YaUmRFGVcp0zGbQSeeLw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gdHZaAoS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C46DC4CED2;
	Sun,  8 Dec 2024 17:03:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733677391;
	bh=Lnz2aWDHGkRniarfLIMsg+D6EF3yAhHrAHetguznFNg=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=gdHZaAoS57Tbn9u04xu8VltLKWm9ujB5ZbP0HWPb7UEOvCwrgJYOKf+tNTwh3KZvA
	 kRipx8xQlojkgr8gnCikhbd1twGNRAT3GZLsBio3v4BIGQfKrjWaYdwkGEiq0kiBRg
	 PfABS2n0d4W65eFpq6dUYjaN4OxOd1IG2DC9Nvu/0rb5H0ynkp8nR/goi/+yakqywT
	 cx79oGPHkKiNm5597j7ic7OIdBoBKaMd+m7iwuF4gsRFbfrmNjEwcSxwfSEK//BwZs
	 nEbZkjYOS0uAAgKVZOQEpABTQBK+/f2acdeDyDqKNIBn8t/1D0UpTSsfTkNOljIQDd
	 /bKsEnTvQc3Sg==
From: Vinod Koul <vkoul@kernel.org>
To: konstantin@linuxfoundation.org, linux-kernel@vger.kernel.org, 
 keith zhao <keith.zhao@starfivetech.com>
Cc: helpdesk@kernel.org, linux-phy@lists.infradead.org, 
 jack.zhu@starfivetech.com, chensy123@21cn.com
In-Reply-To: <20241120085609.199586-1-keith.zhao@starfivetech.com>
References: <20241120085609.199586-1-keith.zhao@starfivetech.com>
Subject: Re: (subset) [PATCH] MAINTAINERS: Remove Shengyang as JH7110 DPHY
 maintainer
Message-Id: <173367738866.1042266.114125862388608986.b4-ty@kernel.org>
Date: Sun, 08 Dec 2024 22:33:08 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2


On Wed, 20 Nov 2024 16:56:09 +0800, keith zhao wrote:
> Shengyang has stepped away from his duty,
> and this email is no longer valid, so removing
> the email from MAINTAINERS.
> 
> 

Applied, thanks!

[1/1] MAINTAINERS: Remove Shengyang as JH7110 DPHY maintainer
      commit: ea68f5c1b85462704b1939e547f9858cca5fcc0d

Best regards,
-- 
~Vinod



