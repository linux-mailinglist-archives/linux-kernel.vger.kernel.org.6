Return-Path: <linux-kernel+bounces-342431-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 309AF988EFD
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Sep 2024 12:35:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 619191C20E1A
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Sep 2024 10:35:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05252185952;
	Sat, 28 Sep 2024 10:35:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=kuruczgy.com header.i=@kuruczgy.com header.b="f5TJBMgN"
Received: from out-180.mta0.migadu.com (out-180.mta0.migadu.com [91.218.175.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C08903D3B3
	for <linux-kernel@vger.kernel.org>; Sat, 28 Sep 2024 10:35:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727519712; cv=none; b=MOePE5fYM8phAHtM1pi7Bamft5dMZa13v4Dmtw/76wPFMJ7WdqkMEpcCQ21RIWikR6D9lSdHUAjfqwhmhj2QXu1FudeI1/hgyBRwFr77A7ULnK9j021MbT10Vxlb19KQxn7bQBx0dCHrjJuCoRLYX7fLOaYUmNn/MiR8ObHaD0g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727519712; c=relaxed/simple;
	bh=nLdvlM+r46/bj0ot7pT+pTfR1IApI5YWisr9Al+BRvo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=m6qNpp4WoP67/UAztlcJqIV9paSxJCuFY4BBaM0LpEXcIidHTZtMJ8ZNimcxjhR6s5vvDO0nC10v4ugpq6BlffL7H5flfiIHnKSZJOwQRaXX+btz60LkbHfaU7dx78M4Ql0Wng7xPUkxohFD6KAZAUzGuXxrNYzpf22wTkiPWro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kuruczgy.com; spf=pass smtp.mailfrom=kuruczgy.com; dkim=pass (1024-bit key) header.d=kuruczgy.com header.i=@kuruczgy.com header.b=f5TJBMgN; arc=none smtp.client-ip=91.218.175.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kuruczgy.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kuruczgy.com
Message-ID: <a9a7cab1-1039-44a8-bf20-33d3b1708b6f@kuruczgy.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kuruczgy.com;
	s=default; t=1727519707;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zpbSMNI4+5T9LQvkTktWG0gkMWFha2E7Vjeq9GNW7hY=;
	b=f5TJBMgNp/wzzkxz6tKQzfBZkrkLL4BBiA61CTxMyJR/aRst8RbuZaxQkPOAtKhcm7KMbO
	MP1jI1WT1wPLIiqhOZ+7BDnd7wu54ilfuaKYXCZ9A4lME/6pkX5C0Mu6uFMhSrj9srW8KA
	yOImeTRrD5Cmh+rULw1MTCLMBgkl6nw=
Date: Sat, 28 Sep 2024 12:35:03 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH 2/3] platform: arm64: Add driver for Lenovo Yoga Slim 7x's
 EC
To: Maya Matuszczyk <maccraft123mc@gmail.com>,
 Hans de Goede <hdegoede@redhat.com>,
 =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Cc: linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org
References: <20240927185345.3680-1-maccraft123mc@gmail.com>
 <20240927185345.3680-2-maccraft123mc@gmail.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: =?UTF-8?Q?Gy=C3=B6rgy_Kurucz?= <me@kuruczgy.com>
In-Reply-To: <20240927185345.3680-2-maccraft123mc@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Dear Maya,

> For now it supports only reporting that the AP is going to suspend and
> the microphone mute button, however the EC seems to also support reading
> fan information, other key combinations and thermal data.

I tested the following:
- When I suspend the laptop, the keyboard backlight turns off, and the 
power button LED starts blinking.
- When I press the Fn+F4 key combo, the KEY_MICMUTE event is correctly 
reported to userspace.

> +// These are the registers that i know about available from SMBUS

> +// These are the values in EC_IRQ_REASON_REG that i could find in DSDT

Nitpick: capitalize "I" if you create a v2

Tested-by: György Kurucz <me@kuruczgy.com>

Best regards,
György

