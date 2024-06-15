Return-Path: <linux-kernel+bounces-215936-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 08A60909910
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Jun 2024 18:46:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A5F291F22112
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Jun 2024 16:46:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F5124962E;
	Sat, 15 Jun 2024 16:46:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=timsurber.de header.i=@timsurber.de header.b="FJIKtU6s"
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE0D9199C2;
	Sat, 15 Jun 2024 16:46:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718469984; cv=none; b=MVHSvmvwMgFfC6Od0AuWXeCBL7fvqHxo3FMUwsvvys94rhOeB+H3UR4oKGhKEjIxB3QpYL3mQib+5WPuylq+skrolQFK8gf3jE8+Ms+dygj0LPe4wVmXEK7Er1d2aU7G639UofIj41AO1QqAFt/OtvI50GFQRLu8G333HuU+V3k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718469984; c=relaxed/simple;
	bh=x5Fo1RoRl54vu/aq9L7rU8oPsB3jaMfi1D8czbmoPVE=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=KX3dwLx8wNx0ekC4teQlLBM01MnweEFbO49T/M7BA3oyStocz+fFbAXWBHGARa4ix/xUuCH7yj9JwOcNxgOZc+rFPuPgGZh1u56rt9roqosXTncJEDxMIQLLZUSG/pvXYV6NRUjUJiKjxPKrrHfx1tOV0sLm4TbjftBx8ntyxzE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=timsurber.de; spf=pass smtp.mailfrom=timsurber.de; dkim=pass (2048-bit key) header.d=timsurber.de header.i=@timsurber.de header.b=FJIKtU6s; arc=none smtp.client-ip=80.241.56.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=timsurber.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=timsurber.de
Received: from smtp102.mailbox.org (smtp102.mailbox.org [IPv6:2001:67c:2050:b231:465::102])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4W1hqP2LM9z9sbt;
	Sat, 15 Jun 2024 18:46:09 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=timsurber.de;
	s=MBO0001; t=1718469969;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HNGZN4oEpKT+sBOXNLogARwwcW1owg1uGbSyFj4/14A=;
	b=FJIKtU6sHScvKyvoHM8eWZqmD1W51co08238jGAPT4/Adfh1P1Nqqu1U7A70GJzkBvayYq
	Fgu+eLd3RxGd1SWd9a36NHPk3o5nAo5KHARQg7QVm0s0PD3N+KAk1wgPadjkAMSpK00Pna
	uVr5PgbHMEYTrXBYJGEoDUJpz4KKVB2Fj1NuC15WJhFEC1oEjxYjze1SQZjz528AG8ynzw
	kh/LmU/sKAs3T/PaO2pV094YDElwm55Jl7Ft+4+3ikxs67amVVVkUvxnurqN6kDYREpUEs
	NgfGaYW05mRppFx5DaFaarzcHx//7FIZHcZ0sht7JCYtnNR0s/mf4xLEsl0dCA==
Message-ID: <ecc86cc9-f5b6-4fb5-88c0-27a1cef59f5c@timsurber.de>
Date: Sat, 15 Jun 2024 18:46:06 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
To: seb-dev@mail.de
Cc: conor+dt@kernel.org, devicetree@vger.kernel.org, heiko@sntech.de,
 jonas@kwiboo.se, krzk+dt@kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-rockchip@lists.infradead.org,
 me@the-space.agency, me@timsurber.de, robh@kernel.org,
 sebastian.reichel@collabora.com
References: <1c702815-3f55-4f62-a743-2463f3141650@mail.de>
Subject: Re: [PATCH v3 2/2] arm64: dts: rockchip: Add FriendlyElec CM3588 NAS
 board
Content-Language: en-US
From: Tim Surber <me@timsurber.de>
In-Reply-To: <1c702815-3f55-4f62-a743-2463f3141650@mail.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 4W1hqP2LM9z9sbt

Hi Sebastian,

using the vendor kernel I had success with "sudo ir-keytable -t -p all".
You have to have all the required protocols under CONFIG_RC_DECODERS 
enabled (the easiest is to enable them all for testing).

Using the above command I can see output when using a normal Sony TV 
remote. I have not tested using the mainline kernel.

Best regards,

Tim


