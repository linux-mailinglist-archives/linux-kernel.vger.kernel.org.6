Return-Path: <linux-kernel+bounces-274749-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 701E2947C35
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 15:51:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A1C921C21BF6
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 13:51:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F0A63BBC9;
	Mon,  5 Aug 2024 13:51:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dUhBfZAI"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC6662C684;
	Mon,  5 Aug 2024 13:51:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722865886; cv=none; b=Dju4ZrIXk9Gvw3XdXufUXVacaBulv1Yij7O7Jfv0+ArpknRozdZtRQXQ2pszzlcPn/L3PJGYCFkx2P5k50PHoDVmwRtSDitgIf8yDOD22vn/pGbYp3yZQ53++OA4nolXIiG+/JOO94wuykm8pVa1cBqh0Cjd+8tAs8Zwip8Jxts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722865886; c=relaxed/simple;
	bh=njtwpWxIF6PT6t/P1Xo146a+8v2Brgo+D7t9IcjqQVE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=X7RKYdqYtN0rktbFtPPOhyEmVgM6wDQmKCi9R8pwX78UCl1Ch5MX3T0RMHTE08Uum+z1sLsnH/9ECQHwjvYQ5bYXGHCFR1Sv/Mk39bPePjWJxOwmlQxjDyXvNWLF/73wUmotTHqg3ArAeTm4mmou14DGaVE5yTJRB8ho5Ehu3lk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dUhBfZAI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50F39C32782;
	Mon,  5 Aug 2024 13:51:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722865886;
	bh=njtwpWxIF6PT6t/P1Xo146a+8v2Brgo+D7t9IcjqQVE=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=dUhBfZAIP99i9hBH3GdyTu1aWK/dr7S8VXyep9pdvAqZYSlaccuIdCvRB9nLOXyYi
	 5czdqfTnDkYE2tYtHRyNdTR+iOKKnkE2n1g/3vs9t57U9Euu7/dGGlve+1UD8lNIfv
	 o4btOwWr8n1oOhjWKKtykPs+TJ6VeFFmoxS+64ujCuYcZ971ZT+3rbD7f+3xKrAnNU
	 +9OrcWXrL4JoAjXVXnJ/DMRcvdD21Wn3XLqvBOW+o00wQkOUTA0s/dKZ5lvFDPZGCt
	 D7OWOhaWYREpErQLYQcYuqtQBvYcEdMNL37MneQuuufNTkN8//hEBK8V30TnY6WvKL
	 SHmNoy7QQsKjQ==
Message-ID: <a3bbcd4f-5618-45e6-a849-279fddf569b1@kernel.org>
Date: Mon, 5 Aug 2024 16:51:19 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 06/12] usb: cdns3-ti: grab auxdata from match data
To: =?UTF-8?Q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Peter Chen <peter.chen@kernel.org>,
 Pawel Laszczak <pawell@cadence.com>, Mathias Nyman
 <mathias.nyman@intel.com>, Nishanth Menon <nm@ti.com>,
 Vignesh Raghavendra <vigneshr@ti.com>, Tero Kristo <kristo@kernel.org>
Cc: linux-usb@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 Kevin Hilman <khilman@kernel.org>,
 =?UTF-8?Q?Gr=C3=A9gory_Clement?= <gregory.clement@bootlin.com>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>
References: <20240726-s2r-cdns-v5-0-8664bfb032ac@bootlin.com>
 <20240726-s2r-cdns-v5-6-8664bfb032ac@bootlin.com>
Content-Language: en-US
From: Roger Quadros <rogerq@kernel.org>
In-Reply-To: <20240726-s2r-cdns-v5-6-8664bfb032ac@bootlin.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 26/07/2024 21:17, Théo Lebrun wrote:
> Current code uses the global `cdns_ti_auxdata` variable as auxiliary
> data passed to of_platform_populate(). Use match data to store a
> pointer to auxdata.
> 
> Current behavior is not changed; it allows future compatibles to provide
> different auxiliary data.
> 
> Signed-off-by: Théo Lebrun <theo.lebrun@bootlin.com>

Reviewed-by: Roger Quadros <rogerq@kernel.org>

