Return-Path: <linux-kernel+bounces-540406-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 93544A4B03B
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Mar 2025 08:23:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AECF517A592
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Mar 2025 07:18:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3160253354;
	Sun,  2 Mar 2025 06:59:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b="HZhjGi2J"
Received: from m16.mail.126.com (m16.mail.126.com [220.197.31.6])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F8201EE00C
	for <linux-kernel@vger.kernel.org>; Sun,  2 Mar 2025 06:58:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740898748; cv=none; b=fOaJqQ5kGDzR2uzDfqI9grqL6UwSoVRkY+E6W/jsFkDBtlE5nXckVgNDiCCahCDT02RViiI8N2BemzUaC3EPIHw47bEQbf9gs6vCMm9bF+4v6eDLEQel5eHKFI1/9teMy61IXpcJGSSFfAcF3BdYk8GgFuSXDoIBTln4YUctFg8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740898748; c=relaxed/simple;
	bh=m3WWx7WaxOLxHF4l3ehA7ZpOfcH46DacagbXvgNtOUU=;
	h=From:To:Cc:Subject:MIME-Version:Content-Type:Message-Id:Date; b=HTKdGS+RstKxP8gspZz62eSxmf+oJKTLmShOaAjhja+tHo+eFHEq4W5eISC25Yu6D6S4PiGMDiBycrcF26GUJzenHR1ddecEGxr9bjyPVA2vkGqwU48jCpPxw/tEtrD2evfp3jEtWpKkAU7poqGK8BiN/AfMhkwxobsEWpj5BS8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com; spf=pass smtp.mailfrom=126.com; dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b=HZhjGi2J; arc=none smtp.client-ip=220.197.31.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=126.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
	s=s110527; h=From:Subject:MIME-Version:Content-Type:Message-Id:
	Date; bh=m3WWx7WaxOLxHF4l3ehA7ZpOfcH46DacagbXvgNtOUU=; b=HZhjGi2
	JsrnBQcwNoycip3OszJqWk9VnjtbbMpDa8wrLMa19Vjnxqx9D6P8QimepMQ1dKWh
	fqY8xAIHr58u0XY3XBy/ZrAWSPOxTCwZoOI5onWgj9DFmwWcDgCmIB+9PCJXZg+q
	fjhgkrTuOA3QF7zX7+U/gXwt6KeRFCwKhmJI=
Received: from localhost (unknown [])
	by gzga-smtp-mtada-g0-3 (Coremail) with SMTP id _____wD3z6Ig_sNnW80gBg--.15879S2;
	Sun, 02 Mar 2025 14:43:44 +0800 (CST)
From: adam_smystery@126.com
To: linux-kernel@vger.kernel.org
Cc: 
Subject: Hello! Rust is better than Golang
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-CM-TRANSID:_____wD3z6Ig_sNnW80gBg--.15879S2
Message-Id:<67C3FE20.066DBE.00001@m16.mail.126.com>
X-Coremail-Antispam: 1Uf129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
	VFW2AGmfu7bjvjm3AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvjxU6fOzDUUUU
Date: Sun, 2 Mar 2025 14:58:53 +0800 (CST)
X-CM-SenderInfo: 5dgdzspvp123xhu1qiyswou0bp/1tbiOgcEumfD7Anx1QAAsm

Hello! Rust is better than Golang


