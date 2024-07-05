Return-Path: <linux-kernel+bounces-242734-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 44DCA928C5B
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jul 2024 18:33:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EA29E1F22112
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jul 2024 16:33:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AC8816A948;
	Fri,  5 Jul 2024 16:33:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cknow.org header.i=@cknow.org header.b="yiIaq9w+"
Received: from out-184.mta0.migadu.com (out-184.mta0.migadu.com [91.218.175.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 792092F32
	for <linux-kernel@vger.kernel.org>; Fri,  5 Jul 2024 16:33:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720197226; cv=none; b=RF6TEGjv6nCoqbm6J0Env8dqLCEcHYWSUtXrqI2laQkdpHEKdElsyWgOq71UMAxssacVFty3EDtQHzXPznYHWzggJaOABZZ1tZsJQq7IqAZRZEN4A9Y+gd1e+/62iF/AYKq1ZE1iQTVid2pZOFEIvB7tzls/9Gula+y3jnYnYxY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720197226; c=relaxed/simple;
	bh=FJ6n1XjUi/eyqCVrXLwkSveH/8hWoV86rGKiEPbK2Tc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=kCtENAzkxPUegdN9F7veVP1UyQYl46HduG0qFGYTP0KUtxMpRe6o4f1rtLjaoEEurNtU3d9S6ebu6xwW1q5E2zCN1OwhYvyFc+V2/73St/b5EG3geL+b039GVqR1cKDNgg93o/hRcxB2MKy9d1g9Tsi7bHzDu5R7KiPyw850Acg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cknow.org; spf=pass smtp.mailfrom=cknow.org; dkim=pass (2048-bit key) header.d=cknow.org header.i=@cknow.org header.b=yiIaq9w+; arc=none smtp.client-ip=91.218.175.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cknow.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cknow.org
X-Envelope-To: heiko@sntech.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cknow.org; s=key1;
	t=1720197221;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=FJ6n1XjUi/eyqCVrXLwkSveH/8hWoV86rGKiEPbK2Tc=;
	b=yiIaq9w+BI8XdSfmrn/mw3BrhdTEssvFxmhBQIQUWxqojvVPi7/Mvkbmaj90RBDg69oH/2
	N6eil8/4OaBOFrIlvkjZCvwhN2Z3EGNNp8+QaPNv10e11VwvQcZw47ultS2eOMcIxRJOp0
	h7EPX1x1PfJayO6dwVutWH4A3NJqrmRL9gKIFVRhj9NWHEk7cVnxF/KS8LZ1u6xWRK/dgq
	+yt/aT/RBI2y82DZ84bymyGHnoH5QxQZDYNbG4m5QPZ9yvCx+PO0Oz9YsXdhiEunb+jEB1
	I5egCnLhAS9zpFoKYLCnfSbl01MTOv25H8uALblUnpdZfaqcgV+2CiJbD/ITzw==
X-Envelope-To: mweigand@mweigand.net
X-Envelope-To: dsimic@manjaro.org
X-Envelope-To: didi.debian@cknow.org
X-Envelope-To: linux-rockchip@lists.infradead.org
X-Envelope-To: devicetree@vger.kernel.org
X-Envelope-To: linux-arm-kernel@lists.infradead.org
X-Envelope-To: linux-kernel@vger.kernel.org
X-Envelope-To: macromorgan@hotmail.com
X-Envelope-To: andyshrk@163.com
X-Envelope-To: jagan@amarulasolutions.com
X-Envelope-To: amadeus@jmu.edu.cn
X-Envelope-To: f.kardame@manjaro.org
X-Envelope-To: michael.riesch@wolfvision.net
X-Envelope-To: wiagn233@outlook.com
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Diederik de Haas <didi.debian@cknow.org>
To: Heiko Stuebner <heiko@sntech.de>
Cc: Maximilian Weigand <mweigand@mweigand.net>,
	Dragan Simic <dsimic@manjaro.org>,
	Diederik de Haas <didi.debian@cknow.org>,
	linux-rockchip@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Chris Morgan <macromorgan@hotmail.com>,
	Andy Yan <andyshrk@163.com>,
	Jagan Teki <jagan@amarulasolutions.com>,
	Chukun Pan <amadeus@jmu.edu.cn>,
	Furkan Kardame <f.kardame@manjaro.org>,
	Michael Riesch <michael.riesch@wolfvision.net>,
	Shengyu Qu <wiagn233@outlook.com>
Subject: arm64: dts: rockchip: Add dma-names to uart-bluetooth rk3566 devices
Date: Fri,  5 Jul 2024 18:22:12 +0200
Message-ID: <20240705163004.29678-2-didi.debian@cknow.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

This is a single patch which adds the dma-names property to the uart
node with a bluetooth subnode on Pine64's rk356x devices.

But that property can potentially be added to several other devices, but
I have zero familiarity with them or their community, so I choose not to
add it to those devices, but inform people via this cover letter.

The dts/dtsi files I found as potential candidates are:
- rk3566-anbernic-rgxx3.dtsi
- rk3566-box-demo.dts
- rk3566-powkiddy-rk2023.dtsi
- rk3566-powkiddy-x55.dts
- rk3566-radxa-cm3.dtsi
- rk3566-rock-3c.dts
- rk3566-roc-pc.dts
- rk3568-rock-3a.dts

