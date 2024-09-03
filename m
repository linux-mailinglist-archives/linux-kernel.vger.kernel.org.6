Return-Path: <linux-kernel+bounces-313842-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 172F496AAA3
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 23:52:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C88DA284695
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 21:52:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A3F31CF295;
	Tue,  3 Sep 2024 21:52:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j4CVNvNj"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8114126C1C;
	Tue,  3 Sep 2024 21:52:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725400344; cv=none; b=qaGtdp998FxdFlaX5wcVKeDHniKF8lacUUmElQ2PDUgHL2MaLsb+6s9B4jdeILJ6J306cmOxj3Mlx2vw6UCAldqum9mlds0pFiAfaPu7dkxWi2aUfHKpKMzwNqfhSxQezwcODNc0+MpX1/pRCk2U8EYFdkOh8IiDzXODQLOBzfQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725400344; c=relaxed/simple;
	bh=IiTH8wkLFMo3xSYbE2TTe8ClIiSdTVnTPCVyWOKDkv4=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=E0t4/T0yDuZOUpO8oy3jYcTfMaZr+SusNLYhK/hbCsqYNYrYySIOzKHwb6CYyeigx7/zZuwTSpo6xKd9CC0m/o4ArvN2VsGDSK5ZbCxRSZa2Z3YDGsbTdCZroBxDrFCpDOK18LNQSl3V7b5wW6L4osdSQ0FgkQDwNVgp0WavJsc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j4CVNvNj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41315C4CEC4;
	Tue,  3 Sep 2024 21:52:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725400344;
	bh=IiTH8wkLFMo3xSYbE2TTe8ClIiSdTVnTPCVyWOKDkv4=;
	h=From:Subject:Date:To:Cc:From;
	b=j4CVNvNjFFIHe1QunhsUEHbJYGpBnpw2kPEjnqWiEkA+cmR94i7Ez88dL+4H4VAnI
	 lsJZQR5V16xy/GF8WakLkptnW+aYRsaliFm7+yHrtBu9dJEIrTkXBvFhqZR9bkYgPU
	 PErDhbXPHxbYDag/BeKmJzHrpL2e2daq3rYh+mnUqJXGAU77uA8RNhf6FEkN2pfu6G
	 TpjrIjECETFN79hWKelbUs504fw77ijmJZkF5a2cij9zFt7dHug+qny4vzt9Lr7OoZ
	 TCib8yDazaZqNizJJDmISdb45MsoJ8Jg9d/jAPu8xs8z7lS/aX7IzejzSncTfm8+bV
	 COeHr1w0o+ihg==
From: "Rob Herring (Arm)" <robh@kernel.org>
Subject: [PATCH 0/4] dt-bindings: trivial-devices: Clean-ups
Date: Tue, 03 Sep 2024 16:52:04 -0500
Message-Id: <20240903-dt-trivial-devices-v1-0-ad684c754b9c@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAASF12YC/x2MQQqAIBAAvxJ7bsG0CPtKdDBdayEsNCIQ/550H
 JiZDIkiU4KpyRDp4cRnqNC1DdjdhI2QXWWQQvZCC4Xuxjvyw+ZAV31LCUdF6zpo5ZXQUMMrkuf
 3n85LKR8/Ms8IZAAAAA==
To: Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
X-Mailer: b4 0.15-dev

This small series drops some duplicate compatibles and fixes an 
incorrect vendor prefix.

Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
---
Rob Herring (Arm) (4):
      dt-bindings: trivial-devices: Drop incorrect and duplicate at24 compatibles
      dt-bindings: trivial-devices: Deprecate "ad,ad7414"
      dt-bindings: trivial-devices: Drop duplicate LM75 compatible devices
      dt-bindings: trivial-devices: Drop duplicate "maxim,max1237"

 Documentation/devicetree/bindings/trivial-devices.yaml | 15 ++-------------
 1 file changed, 2 insertions(+), 13 deletions(-)
---
base-commit: 8400291e289ee6b2bf9779ff1c83a291501f017b
change-id: 20240903-dt-trivial-devices-73ebb593f309

Best regards,
-- 
Rob Herring (Arm) <robh@kernel.org>


