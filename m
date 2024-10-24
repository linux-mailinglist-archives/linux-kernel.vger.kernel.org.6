Return-Path: <linux-kernel+bounces-379168-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C80C9ADAF8
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 06:34:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F20201F22C36
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 04:34:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C33B16D4E5;
	Thu, 24 Oct 2024 04:34:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=seriousbit.net header.i=@seriousbit.net header.b="q7MsURv0"
Received: from pc232-5.mailgun.net (pc232-5.mailgun.net [143.55.232.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6523BA4B
	for <linux-kernel@vger.kernel.org>; Thu, 24 Oct 2024 04:34:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=143.55.232.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729744464; cv=none; b=QNE3iT8aPWcA8hwDcTHcr00/pc43j7ucpx0PpHAVrMSnRch/duPHSPGYAr6HBPJuf4i3oUk/j8wRd3Neon/dtxOcPoUlAkqyIpp5spyNi1wtTYy/631nTzL12rKR33gDAnsgQZbi4o8SPQdmASnK7/omYObeAFUSFBDm00PMOsc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729744464; c=relaxed/simple;
	bh=eYQilZgoxfpRKYuLtiBPlP0JV8yRHkodejWaDdMMh9Y=;
	h=Date:Mime-Version:Subject:From:To:Message-Id:Content-Type; b=ZthSh69U1eMOuJ37t6Ewa95D3uYOWqL+1+dHaW4QwBtL22/j4Aj116J9H8XiFcOBrvypR9uJbX6VylE2r7H+drs3Pt+ZlfMqlOwQQZ2mnD4dJQKe8Fq0apM0W49G9/GGC7PgYVDG/r81EPBA7EXn6/FS6rFgVI+G6T0H5Yjs58g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=seriousbit.net; spf=pass smtp.mailfrom=seriousbit.net; dkim=pass (1024-bit key) header.d=seriousbit.net header.i=@seriousbit.net header.b=q7MsURv0; arc=none smtp.client-ip=143.55.232.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=seriousbit.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seriousbit.net
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=seriousbit.net; q=dns/txt; s=smtp; t=1729744461; x=1729751661;
 h=Content-Type: Content-Transfer-Encoding: Message-Id: Reply-To: To: To: From: From: Subject: Subject: Mime-Version: Date: Sender: Sender;
 bh=eYQilZgoxfpRKYuLtiBPlP0JV8yRHkodejWaDdMMh9Y=;
 b=q7MsURv0K3Vqhvczj0zpRh/qF2OvGHvVpG6cbfGQvRJUqX5a7wZRU8MNCtlxKgEIxFC7qw8sUHec9aqj/8Zwl4yPUYqtaCXL7UhMoq5yJnSXGvWws6ocU54ukmPU3hvHMcmhrL6zjjbxRV1tOvjgneYtXxO7KevzTpO9QoEo17I=
X-Mailgun-Sending-Ip: 143.55.232.5
X-Mailgun-Sending-Ip-Pool-Name: 
X-Mailgun-Sending-Ip-Pool: 
X-Mailgun-Sid: WyIxYmU0YyIsImxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmciLCJiYjE0Il0=
Received: by 42a8dbfdd06d with HTTP id 6719ce4db3bb54ce3bf589c6; Thu, 24 Oct 2024
 04:34:21 GMT
Sender: support@seriousbit.net
Date: Thu, 24 Oct 2024 04:34:21 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Subject: Please activate your NetBalancer account
From: NetBalancer Support <support@seriousbit.net>
To: linux-kernel@vger.kernel.org
X-Mailgun-Track: false
Reply-To: support@netbalancer.com
Message-Id: <20241024043421.fe79ec4a876eee12@seriousbit.net>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=ascii

Hello xw9WqmM7rc,

Welcome to NetBalancer!
To activate your account please click the link below to verify your email address:

https://netbalancer.com/account/activate?username=xw9WqmM7rc&code=R80450

Or paste your validation code R80450 on the validation page:
https://netbalancer.com/account/activate

Happy balancing!

Best Regards,
NetBalancer's Highly Paid Robot

