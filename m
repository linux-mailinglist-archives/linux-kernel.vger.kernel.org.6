Return-Path: <linux-kernel+bounces-179702-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DB2CE8C63AB
	for <lists+linux-kernel@lfdr.de>; Wed, 15 May 2024 11:30:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9BE6F2845ED
	for <lists+linux-kernel@lfdr.de>; Wed, 15 May 2024 09:30:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 659ED59151;
	Wed, 15 May 2024 09:30:21 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDE2155E5B
	for <linux-kernel@vger.kernel.org>; Wed, 15 May 2024 09:30:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715765421; cv=none; b=CtidBjVz0gN76YSAatC47jwpUsrzbTAMY0DvjP0S3DnTw8Kr54oPOq8p0NZo1v1VPqZKkYkKD5FnXPsHeSQUY3rfmgWbIPWclYTjTShLNj1cTGM4Owgq6OOSRvbNjBegWmySKPciynzBaXPZRFP8LoS2PSjfpSxBNAUk2zCYc7g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715765421; c=relaxed/simple;
	bh=wiG/ztN5BJ8+N/GyWnP3SNmjHscF0zff42Yvlf/4V48=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Hr00vO2sgtwtp+BC4mxTKANsk4Ub/cycF1ajORSaFOenuFnAQVk7xLhHk1OTyPztLFnnWCg63bJOmZWo41X5GPAn6HIsjhi2Evj/JPbNgCFM6oNm9RPW4l4RW/BAVYwGXgNJWlcb7xSxuIeVnvJg0hn78+qc6hoamNI8KS23BxI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A06261007;
	Wed, 15 May 2024 02:30:40 -0700 (PDT)
Received: from usa.arm.com (e103737-lin.cambridge.arm.com [10.1.197.49])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id D8ADC3F7A6;
	Wed, 15 May 2024 02:30:14 -0700 (PDT)
From: Sudeep Holla <sudeep.holla@arm.com>
To: Russell King <linux@armlinux.org.uk>,
	Liviu Dudau <liviu.dudau@arm.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	"Rob Herring (Arm)" <robh@kernel.org>
Cc: Sudeep Holla <sudeep.holla@arm.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] arm: vexpress: Remove obsolete RTSM DCSCB support
Date: Wed, 15 May 2024 10:30:07 +0100
Message-ID: <171576525046.1945769.9546905970570452026.b4-ty@arm.com>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240510123238.3904779-1-robh@kernel.org>
References: <20240510123238.3904779-1-robh@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Fri, 10 May 2024 07:32:35 -0500, Rob Herring (Arm) wrote:
> The Arm Versatile DCSCB support is unused as the compatible
> "arm,rtsm,dcscb" is unused in any .dts file. It was only ever
> implemented on a s/w model (RTSM).
>

Applied to sudeep.holla/linux (for-next/vexpress/updates), thanks!

[1/2] arm: vexpress: Remove obsolete RTSM DCSCB support
      https://git.kernel.org/sudeep.holla/c/41fcb32dbca4
[2/2] dt-bindings: arm: Remove obsolete RTSM DCSCB binding
      https://git.kernel.org/sudeep.holla/c/5c47d9a27403
--
Regards,
Sudeep


