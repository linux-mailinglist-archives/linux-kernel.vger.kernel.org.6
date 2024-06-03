Return-Path: <linux-kernel+bounces-199286-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A50C8D84EB
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2024 16:27:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 56ABF28952F
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2024 14:27:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E629F1304AF;
	Mon,  3 Jun 2024 14:26:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ufmipIw6"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A238130487
	for <linux-kernel@vger.kernel.org>; Mon,  3 Jun 2024 14:26:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717424805; cv=none; b=mIv97ZgBjDbt0WoxA81+aqPM2O71MgGtfv8wbUL4KyaxXGKy+6U1h4hDrYU3+jhyqSPHM+7QHjJNBHFPKPWR5ajoARJLu7tXjm42HlvyDVx+VPKZ8xBYSlGZEESqmZEBPWxNK3yqA8vXlXobO2/aB6+AjNwYHOLDv49esFbMlBU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717424805; c=relaxed/simple;
	bh=XbqgDvXBz98fW3K9TL4sNj0U9UCGx6HAtAQovA5h28s=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=fZP70cxqO06BAHbHpZEHo2zdjfcItqClimztMLwoqPke2oFnpzulUm0bTNjJj+MvfaSJ5NUKgk/Cnz73lITbTqRgmBwjfYmtR0JnJT5rNYbCasvphrm2tyJKEK5m2vgC8gVxdKPpd1GUYrwAjuqSV3HUcrGEUnDVM/58p4Xomjo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ufmipIw6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A3332C4AF0A;
	Mon,  3 Jun 2024 14:26:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717424805;
	bh=XbqgDvXBz98fW3K9TL4sNj0U9UCGx6HAtAQovA5h28s=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=ufmipIw6HeUA1zK8bogPfLmZ8Fh6eSCqboINCFI5xx/hRTF1XqchAidWd73FPqCeT
	 7XeYctIoXT21+dZ4f46/3686ykWa9Nz/oOTmZ/PMf59xMFTmOBpIg1+o8X1XYElmIO
	 0PjbT8YlRm9uLwGk4i6i91VMFxeWK7KHrrSdc3r1RQXFqGWGWq0mpZBlCyGCQAjqPz
	 74S3QYgDLvWkb93LlC0qNz9+EEwRkljUOQnEyuWCdeBUckMxTXy1rNiIZBaZ+Mq4Vj
	 JjlQBc2RNn2nZRCmPzhmc9wKhv2aBruDB0J0aHUYbw/OWT927cCGRMt38Wrd4PIqCO
	 DVldp0g8Pt+1g==
From: Vinod Koul <vkoul@kernel.org>
To: jack.zhu@starfivetech.com, changhuang.liang@starfivetech.com, 
 linux@treblig.org
Cc: linux-phy@lists.infradead.org, linux-kernel@vger.kernel.org
In-Reply-To: <20240527205937.165325-1-linux@treblig.org>
References: <20240527205937.165325-1-linux@treblig.org>
Subject: Re: [PATCH] phy: starfive: remove unused struct 'regval'
Message-Id: <171742480328.106728.1799790392907893940.b4-ty@kernel.org>
Date: Mon, 03 Jun 2024 19:56:43 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13.0


On Mon, 27 May 2024 21:59:37 +0100, linux@treblig.org wrote:
> 'regval' is unused since the original
> commit f8aa660841bc ("phy: starfive: Add mipi dphy rx support").
> 
> Remove it.
> 
> 

Applied, thanks!

[1/1] phy: starfive: remove unused struct 'regval'
      commit: 9d3799c3e807ab5777cda6ae48ebc127b83bc8b0

Best regards,
-- 
Vinod Koul <vkoul@kernel.org>


