Return-Path: <linux-kernel+bounces-385224-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 942289B3435
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 16:01:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C5B081C21D83
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 15:01:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1DCF1DDC2F;
	Mon, 28 Oct 2024 15:01:44 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FEC815E5B8;
	Mon, 28 Oct 2024 15:01:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730127704; cv=none; b=eSXkyjBYlBlTydPzHDxG6+MSThfV/v8jL4HnocnAPMo4xgBOkdrsAjL0yfm94hgPE9W69bWlYfbFkXJQDGfRL5amR0dxKoGa3G7KPojGUv8wxG3Ndr4H1520U65cPDPmHb3IzsLomlrTe3ScSz8eoe/azH4G95NOpmalKqVn+as=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730127704; c=relaxed/simple;
	bh=PHbC3/39UDyIVpwwDIVDZ2H1ENhf3XL0YO4KbYRVoBs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dagOZYZbTlmsIQZ0PQyTeQrUj9YJ+SbAVEXQnsJtIOKk3kDiPRNUlXnKA4OajmvwnY7PUS3BHjJqj6UccQbEr2WgpPc5gtYYwHxKHbjJBbsmfXh4aSTNHeSDFGGWUJBmMKjfgONuVz2UEGxvuoBjmcdigzaVW3cqSX/Slcm3lhI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 33327497;
	Mon, 28 Oct 2024 08:02:11 -0700 (PDT)
Received: from usa.arm.com (e133711.arm.com [10.1.196.55])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 6CCCD3F73B;
	Mon, 28 Oct 2024 08:01:40 -0700 (PDT)
From: Sudeep Holla <sudeep.holla@arm.com>
To: linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	arm-scmi@vger.kernel.org,
	Cristian Marussi <cristian.marussi@arm.com>
Cc: Sudeep Holla <sudeep.holla@arm.com>
Subject: Re: [PATCH] firmware: arm_scmi: Reject clear channel request on A2P
Date: Mon, 28 Oct 2024 15:01:38 +0000
Message-Id: <173012765846.2640935.17751629825029165429.b4-ty@arm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241021171544.2579551-1-cristian.marussi@arm.com>
References: <20241021171544.2579551-1-cristian.marussi@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Mon, 21 Oct 2024 18:15:44 +0100, Cristian Marussi wrote:
> The clear channel transport operation is supposed to be called exclusively
> on the P2A channel from the agent, since it relinquishes the ownership of
> the channel to the platform, after this latter has initiated some sort of
> P2A communication.
> 
> Make sure that, if it is ever called on a A2P, is logged and ignored.
> 
> [...]

Applied to sudeep.holla/linux (for-next/scmi/fixes), thanks!


[1/1] firmware: arm_scmi: Reject clear channel request on A2P
      https://git.kernel.org/sudeep.holla/c/a0a18e91eb3a
--
Regards,
Sudeep


