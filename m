Return-Path: <linux-kernel+bounces-514041-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 42D0BA351A2
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 23:52:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4CA941891A13
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 22:51:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0348E20E314;
	Thu, 13 Feb 2025 22:50:40 +0000 (UTC)
Received: from fgw20-7.mail.saunalahti.fi (fgw20-7.mail.saunalahti.fi [62.142.5.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 161A62753E3
	for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2025 22:50:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.142.5.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739487039; cv=none; b=PA3MGhjylOzIKN3GRRqwMi7RlRK0KMVJuDhT2FrQuzSBuGNDvJ2z1yl0A0cJaaNX2ZJu84FGiqBMExZQ0rYwTSo5A9fFzL5DQl1V6dDxsYGyvdD4XWOhs3gbv443NnmlU33AZvVA9Zljqm/Qdjs1B8W6+cc4L4siA4U5OAUg0d4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739487039; c=relaxed/simple;
	bh=S82i4vGj6R1U5IsQWK+bhits1yoU7F2bx83mR9VBT6w=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=L3Fl5G8ozRS/3bBZ+g4WXlJbTNRNoyyKS0TM4ILC9ni1fzo2NvTtscDjTlgxVvqGJ45mWby2rEBqS7Nt1ApF/VN/GxLYH3dQvrntMW6raIVZa32u9+B/v6rJ5ZwQSRxBNm1qriokUBnf7cFnleE45npaMFR3bUvPoMKtcYzG5s4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com; spf=fail smtp.mailfrom=gmail.com; arc=none smtp.client-ip=62.142.5.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=gmail.com
Received: from localhost (88-113-26-232.elisa-laajakaista.fi [88.113.26.232])
	by fgw20.mail.saunalahti.fi (Halon) with ESMTP
	id ed3944a9-ea5c-11ef-9d70-005056bd6ce9;
	Fri, 14 Feb 2025 00:50:30 +0200 (EET)
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Fri, 14 Feb 2025 00:50:30 +0200
To: "20241010025317.2040470-1-aryan.srivastava@alliedtelesis.co.nz" <20241010025317.2040470-1-aryan.srivastava@alliedtelesis.co.nz>
Cc: "Markus.Elfring@web.de" <Markus.Elfring@web.de>,
	"andi.shyti@kernel.org" <andi.shyti@kernel.org>,
	"linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v10 0/2] i2c: octeon: Add block-mode r/w
Message-ID: <Z653Nn_UO47pgRj8@surfacebook.localdomain>
References: <20241010025317.2040470-1-aryan.srivastava@alliedtelesis.co.nz>
 <77e95bcdbb1cb986686487d777f8966dca0cf435.camel@alliedtelesis.co.nz>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <77e95bcdbb1cb986686487d777f8966dca0cf435.camel@alliedtelesis.co.nz>

Mon, Nov 11, 2024 at 01:36:22AM +0000, Aryan Srivastava kirjoitti:
> Hi Andi, did you have anymore comments for this patch series?

I have comments. Can you address them, please?

-- 
With Best Regards,
Andy Shevchenko



