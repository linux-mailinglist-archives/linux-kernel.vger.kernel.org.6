Return-Path: <linux-kernel+bounces-265073-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 897BD93EC2E
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 06:00:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3274A1F22883
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 04:00:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6744C12FB31;
	Mon, 29 Jul 2024 03:58:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KyaUffV6"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DF44823AF;
	Mon, 29 Jul 2024 03:58:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722225529; cv=none; b=LlN0J09OWkDj85bchuLBDeUWgbOhkANYwGwxQW72JLgQPWvX7qrjxlW+fJChD22UaxlNj5O7L4qbTMcq4XP19qpLZLJVfWoJoj77wChVJjk6EHsy2e500QfOVwrmZwLm2Tv7xV5r5VExa8SvnI9eOtxQ5ulEPID0T96tMnpiaAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722225529; c=relaxed/simple;
	bh=ATaRItJ/Sz0VUq0W/PC5liODZCDYtH2gbLIdYmeEUIg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IFCZi4so0/vXXxILii/WYJ80g5l97M9bkz8jPPm+r5DFuh3+FsNc3x4jypbwBrkXj9cDtOnrijRNzTkILFkw13yoIGsCP2f84XdoMVVkUqCj95IrgLcWsR5JP92XzJH5MFEBs4wleKFo5zwIa2i9KEn5OlYolqGkhjqiCVct8pU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KyaUffV6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F9E0C4AF10;
	Mon, 29 Jul 2024 03:58:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722225529;
	bh=ATaRItJ/Sz0VUq0W/PC5liODZCDYtH2gbLIdYmeEUIg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=KyaUffV647u60mkzU5NbJv3ZT2RDfb6X9PWOLZwIOlaFrWsUtVW3x3kXumhA+yqn8
	 1iGtNUwyD2QF8Af/Aag6yhNgpQQ3pMMI0YjnsBX1+wM6o0LZ8XOWsx5HFEJvLfc8WN
	 QZ00CrcVj85zcAgd3LDs8fXwf7DeHyBimGF6PC3CTIhOCQa7eqZ7XD+rk0xCe0gjNp
	 B3PNtJyAaZaMx2TNs8I+UHnuGIxV3nLKpNBvfJ3qwH8en0z6qOpxySH2Rj1vIqrKrM
	 7aF+q0LwRAgay/Kz9DNz7FKiAm6X26MzIxAFWQK4jFPeZ01P2cfGy5oW6guw9ESvRi
	 ykR9R3cMV046Q==
From: Bjorn Andersson <andersson@kernel.org>
To: linux-kernel@vger.kernel.org,
	"Lin, Meng-Bo" <linmengbo06890@proton.me>
Cc: Konrad Dybcio <konrad.dybcio@linaro.org>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	linux-arm-msm@vger.kernel.org,
	devicetree@vger.kernel.org,
	phone-devel@vger.kernel.org,
	~postmarketos/upstreaming@lists.sr.ht
Subject: Re: [PATCH v2] arm64: dts: qcom: msm8916-samsung-grandmax: Add touchscreen
Date: Sun, 28 Jul 2024 22:58:15 -0500
Message-ID: <172222551318.175430.17570782671190447857.b4-ty@kernel.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240718112715.6117-1-linmengbo06890@proton.me>
References: <20240718112715.6117-1-linmengbo06890@proton.me>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Thu, 18 Jul 2024 11:28:57 +0000, Lin, Meng-Bo wrote:
> Grand Max uses an Imagis IST3038 touchscreen that is connected to
> blsp_i2c5. Add it to the device tree.
> 
> 

Applied, thanks!

[1/1] arm64: dts: qcom: msm8916-samsung-grandmax: Add touchscreen
      commit: 1e19ffdb780a43f34d5da28b7f84ae8c23b47451

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>

