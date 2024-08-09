Return-Path: <linux-kernel+bounces-280953-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 96FBB94D154
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 15:34:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 13979B229D8
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 13:34:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 879271953A2;
	Fri,  9 Aug 2024 13:34:18 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19EFB18C93F;
	Fri,  9 Aug 2024 13:34:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723210458; cv=none; b=jVXqpHFvA+s7VgXBhRF2Wi6P5fuwZV3BiJ5/uykwAxUKkldhz6zB2GiXSHMeXwIJQRzPlI5CDuRBUYbJAu3UJyNHG9dw1UDJeDRikN5se5a4sr8rWIZx8weCiA1GIdbCSxy16C05dcqn3QRmkruaEkWEtJBg48Ct1ZebLIOZTZk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723210458; c=relaxed/simple;
	bh=xTIPNnNqHm8kBzq4Vchu+bZszGcedwE3GmPS02bHwDE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pb/qG4fE7rPBkgb4pUqhu9Y5OFFEvAehogyZSJDBz9YtL+V7Ilf2HPmSxSKCcgZNWRsOiWYvGlUv2eTJmoPVDJYLhBq818EEieC2mamBZC5y9WFMePyR/BvjCZ/ktT/F01nNO/OiKY17Sle4k3k3Ve2MCAmCpA93+l3C+bfNIEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id EAE9713D5;
	Fri,  9 Aug 2024 06:34:40 -0700 (PDT)
Received: from usa.arm.com (e103737-lin.cambridge.arm.com [10.1.197.49])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id CE4DF3F6A8;
	Fri,  9 Aug 2024 06:34:12 -0700 (PDT)
From: Sudeep Holla <sudeep.holla@arm.com>
To: liviu.dudau@arm.com,
	lpieralisi@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	Debbie Martin <Debbie.Martin@arm.com>
Cc: Sudeep Holla <sudeep.holla@arm.com>,
	linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: dts: arm: Add stdout-path
Date: Fri,  9 Aug 2024 14:33:54 +0100
Message-ID: <172321027997.1572956.9970711317320804588.b4-ty@arm.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240730103758.907950-1-Debbie.Martin@arm.com>
References: <20240730103758.907950-1-Debbie.Martin@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Tue, 30 Jul 2024 11:37:58 +0100, Debbie Martin wrote:
> Add stdout-path to the Arm devicetrees to specify the primary console.
> This means that distributions can boot without the need for
> platform-specific command line parameters i.e. they can use earlycon
> with no parameters and no console argument is needed at all.
>

Applied to sudeep.holla/linux (for-next/juno/updates), thanks!

[1/1] arm64: dts: arm: Add stdout-path
      https://git.kernel.org/sudeep.holla/c/9d4a984a53be
--
Regards,
Sudeep


