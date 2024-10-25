Return-Path: <linux-kernel+bounces-381233-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E4669AFC49
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 10:14:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 61E76286789
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 08:13:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B324B1C9EDC;
	Fri, 25 Oct 2024 08:13:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=johanneskirchmair.de header.i=@johanneskirchmair.de header.b="dClucyDY"
Received: from bulk0.mail-out.lima-city.de (bulk0.mail-out.lima-city.de [91.216.248.212])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB2EB1B6D11;
	Fri, 25 Oct 2024 08:13:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.216.248.212
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729844033; cv=none; b=Y7xBHlYFP1gueqXtiuOCULlU/83dC0fRlCoaYoThaAttgS7xG1Cyqb7STIo2SOZmM8FxrEgr57o9R6FtaVRT5uD7q5Eb70ovBKSt4XLHJm3/Q95mz3NfsfBc95IEu9rUD1SrwaPld7wzTOICKd+wjku6gZWd9lM9CCEcfttBm6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729844033; c=relaxed/simple;
	bh=P3R6bpWXHVToa3o5mnFLcdTIAER9hOUy5GkSK3oxbIU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Y303SUHLGDl0LMARv5ta2JAZlCIA4qjz2B4ce1zhYhqWzaPsNwkP9XcGb4ZUktMz1yqkLmdCdMaqWXT6h9f0kllp1MJOpM3vEpNCjmOQI8P3P696N9Scc0z3wU8zGCx92x7NvdyJSdCWmtoQ9JibmjpOby8E45S7oEG0jP0LFfo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=johanneskirchmair.de; spf=none smtp.mailfrom=johanneskirchmair.de; dkim=pass (1024-bit key) header.d=johanneskirchmair.de header.i=@johanneskirchmair.de header.b=dClucyDY; arc=none smtp.client-ip=91.216.248.212
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=johanneskirchmair.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=johanneskirchmair.de
From: mailinglist1@johanneskirchmair.de
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=johanneskirchmair.de;
	s=securedbylima-20161106; t=1729843565;
	bh=P3R6bpWXHVToa3o5mnFLcdTIAER9hOUy5GkSK3oxbIU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=dClucyDY1RF8+yabq5q7fGMmYV0yilRAK4cAeI6j/16NJ/0+n0VCZ1uDg18uP5/DZ
	 E9YptnsWHT40GY0Oeylm2JwhtJZz8unLpwecO7ppMg+Vw1ND8U0laH6sdlAAhg6YCF
	 qjnfFRZm8I/4Lph4zPSAPiQDmt+7CQtlyx7q7n5s=
To: aford173@gmail.com
Cc: johannes.kirchmair@skidata.com,
	Laurent.pinchart@ideasonboard.com,
	airlied@gmail.com,
	alexander.stein@ew.tq-group.com,
	andrzej.hajda@intel.com,
	catalin.marinas@arm.com,
	conor+dt@kernel.org,
	daniel@ffwll.ch,
	devicetree@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	festevam@gmail.com,
	frieder.schrempf@kontron.de,
	jernej.skrabec@gmail.com,
	jonas@kwiboo.se,
	kernel@pengutronix.de,
	kishon@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	l.stach@pengutronix.de,
	linux-arm-kernel@lists.infradead.org,
	linux-imx@nxp.com,
	linux-kernel@vger.kernel.org,
	linux-phy@lists.infradead.org,
	linux-pm@vger.kernel.org,
	maarten.lankhorst@linux.intel.com,
	marex@denx.de,
	mripard@kernel.org,
	neil.armstrong@linaro.org,
	p.zabel@pengutronix.de,
	rfoss@kernel.org,
	robh+dt@kernel.org,
	s.hauer@pengutronix.de,
	shawnguo@kernel.org,
	tzimmermann@suse.de,
	ulf.hansson@linaro.org,
	victor.liu@nxp.com,
	vkoul@kernel.org,
	will@kernel.org
Subject: imx8mp: HDMI display blank/black problems
Date: Fri, 25 Oct 2024 10:05:44 +0200
Message-Id: <20241025080544.136280-1-mailinglist1@johanneskirchmair.de>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240203165307.7806-1-aford173@gmail.com>
References: <20240203165307.7806-1-aford173@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hey, 
We had some problems with the hdmi on the imx8mp and wanted to leave, what we found out about it, somewhere for others to find it.

The problem was that our hdmi display sometimes stayed blank after hot plugging and sometimes at startup. On older kernel versions 6.6 we did not have the problem with the not mainlined hdmi patches. 
We tracked the commit down that introduced the problem for us. It was the following “driver core: Enable fw_devlink=rpm by default”  https://lore.kernel.org/lkml/20231113220948.80089-1-saravanak@google.com/
So we switched back to FW_DEVLINK_FLAGS_ON via kernel parameter. Don’t really understand what the problem with RPM is.

So, this information is just for reference. Maybe someone has an idea what is going on here. And how to fix the problem in a more proper way.

Best regards Johannes

