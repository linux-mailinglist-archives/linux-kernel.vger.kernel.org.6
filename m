Return-Path: <linux-kernel+bounces-273960-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 14FAE947028
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Aug 2024 19:51:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B71851F21245
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Aug 2024 17:51:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF8261311AC;
	Sun,  4 Aug 2024 17:51:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c+aGA5qY"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25EEF79C2
	for <linux-kernel@vger.kernel.org>; Sun,  4 Aug 2024 17:51:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722793905; cv=none; b=ttcUVK0fcw3BLzm3Ff0U3QOvgFE6B7BPbf2em3iy/piBROhKP3h7kt+qqBpW9ELDiJAOO5wa6Nog9XTwBf523zjO8R2NGPEg9NIoQrnme3MSGFWonnbN8IThmWv+qTUJ6Eg+DI39IGOYcgz+4msOvdTruUTVQnBYuULWxk4RRc4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722793905; c=relaxed/simple;
	bh=r/1ogIL9uCeZfCWGinl7eqMXqHeEKasFVr9Re0kbDSk=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=Yp7xNQ6UbNBwK454+reRfR38k742MG8cfLcBbdvmLLQ44DcUJ7/tjiSrJ69vfOVrtB907uKh3Ap8A23cEZQ+X9IZXBkPm5Ay4Pt7jr2KIgq4bFsM9sPqmUjul4bVekCewxusUX8KojO3Z7UR8sH/EJ67jpPB7SW4yev90jcYyVI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c+aGA5qY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E773DC32786;
	Sun,  4 Aug 2024 17:51:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722793904;
	bh=r/1ogIL9uCeZfCWGinl7eqMXqHeEKasFVr9Re0kbDSk=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=c+aGA5qYtEspaJ65GUf1zaUeFBA8rpTxC4psdmkvpN8jnmTMIdBoAGVnZunzeUEib
	 e3TZhHnQecrN+RB3QHL5awdhlZAeRSCO1iTHw2U2Imlq5mb1QcoMRF5QCPndKQJ2+F
	 ztExuWUDpCvBY2iEo6pwP3YfusymIw6PkVyQFWjF/CqOuoRY5MgUC5d9VxSoUJqrle
	 nPPTZZL0Xxxpwt7uD8vaHd8/AoYDITKnJRU++PPg3Tnfq9aUnjxbusFHzVOT1oHRrt
	 ADz9SpiUqUdYn3jLAokem3VhiiRc0tlFfnOp2D9d92gKgfEeEA32WCRcxK9hvFvpxm
	 nSfepjPEljy/Q==
From: Vinod Koul <vkoul@kernel.org>
To: kishon@kernel.org, sergio.paracuellos@gmail.com, 
 florian.fainelli@broadcom.com, krzysztof.kozlowski@linaro.org, 
 robh@kernel.org, frank.li@vivo.com, Stefan Eichenberger <eichest@gmail.com>
Cc: linux-phy@lists.infradead.org, linux-kernel@vger.kernel.org
In-Reply-To: <20240711131612.98952-1-eichest@gmail.com>
References: <20240711131612.98952-1-eichest@gmail.com>
Subject: Re: [PATCH v1] phy: marvell: phy-mvebu-cp110-comphy: improve
 eth_port1 on comphy4
Message-Id: <172279390156.406109.13116235675996046154.b4-ty@kernel.org>
Date: Sun, 04 Aug 2024 23:21:41 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13.0


On Thu, 11 Jul 2024 15:12:47 +0200, Stefan Eichenberger wrote:
> According to the CN9100_MPP_information document, CP_SRD4 (comphy 4)
> supports 2500 BASE-X and 5000 BASE-R for ETH_PORT1. I was able to test
> that 2500 BASE-X is indeed supported. Unfortunately, our HW does not
> support 5000 BASE-R, but I assume from the document that it does, so I
> set the muxing there too to 0x1.
> 
> 
> [...]

Applied, thanks!

[1/1] phy: marvell: phy-mvebu-cp110-comphy: improve eth_port1 on comphy4
      commit: 8c9f085ae3384c5dfc0bc5f2f785b7adbf7d756b

Best regards,
-- 
Vinod Koul <vkoul@kernel.org>


