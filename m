Return-Path: <linux-kernel+bounces-553148-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A37F2A584A4
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Mar 2025 14:50:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3C033188E0BB
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Mar 2025 13:50:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 441CB1D8DFE;
	Sun,  9 Mar 2025 13:50:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b="Ld+OGBTo"
Received: from sendmail.purelymail.com (sendmail.purelymail.com [34.202.193.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 015F010E5
	for <linux-kernel@vger.kernel.org>; Sun,  9 Mar 2025 13:50:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=34.202.193.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741528215; cv=none; b=rTNJ65vwYXUcvuLD7y12ry7Azk+4iVpSJSyD/AQ2Shki4wSsAjmAMvr5lLDyzfqG9vhpQnll4RaZYBPWIMWkOiMMQqYCTteyrmw0xtf0tfiUrmZDn9BtX9XlBHFW+k79KS6M6t0RN28Ygh00WLn5xq6nnVSRSZ/tbGf8dPPBeWQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741528215; c=relaxed/simple;
	bh=G1hejKLDvUrNRMC63yVoF7zEQMOaGnYjgs2MYcPbuL0=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:From:To:Cc:
	 References:In-Reply-To; b=Cy2jkIrX076vfMvJLjAiiZ4mwMWyy/ZX6TnWLyvbaltmF2TlkNqjFv9maH9r+RbQRegnCtjRklSMnNs2Ri7T35mrUU7KMbB2+D0JDN5QBd5xaZx4xcL12umImsVyksm2oSmDEluftN+zC+IwUevGNAFLylDfbco8I9b4lpCRyOQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mentallysanemainliners.org; spf=pass smtp.mailfrom=mentallysanemainliners.org; dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b=Ld+OGBTo; arc=none smtp.client-ip=34.202.193.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mentallysanemainliners.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mentallysanemainliners.org
DKIM-Signature: a=rsa-sha256; b=Ld+OGBToQ2Rskc3LCPaPVwRkUXTyBr9Uz4nnibZ4BnlSmhq/anii+/L95KlURW6omngaBCiKqkYhFnfUHEUVxqRf4192eWtKDpPyP+nZwHkTK1hP7wTQRC9JLRKUUkxb3rgog/axrEZf5slc2+Es3gu12GJ0OxRlUvpej8fHLvcpQJxnNq5BQvDoAijrI8HglJCzoD074JllalXKnrGXVUI2sJ0BKGO5fZWoS80ILvd+W0veXq5G6D2zxmE4ksiOKRYVsCSaVfPFgyElOT4L1QWE2ha12s7zk64W3MpWkujBLNDEaOnJW0k97dqsed59U5ottVBtjWK47uhcdvY2fw==; s=purelymail3; d=purelymail.com; v=1; bh=G1hejKLDvUrNRMC63yVoF7zEQMOaGnYjgs2MYcPbuL0=; h=Feedback-ID:Received:Date:Subject:From:To;
Feedback-ID: 68247:10037:null:purelymail
X-Pm-Original-To: linux-kernel@vger.kernel.org
Received: by smtp.purelymail.com (Purelymail SMTP) with ESMTPSA id -2065352892;
          (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
          Sun, 09 Mar 2025 13:49:35 +0000 (UTC)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sun, 09 Mar 2025 14:49:32 +0100
Message-Id: <D8BS7PJ6LNYY.28AK1FF2MR85S@mentallysanemainliners.org>
Subject: Re: [PATCH RFC/RFT 08/12] clk: samsung: exynos990: Use
 platform_driver_probe() to avoid __refdata
From: "Igor Belwon" <igor.belwon@mentallysanemainliners.org>
To: "Krzysztof Kozlowski" <krzysztof.kozlowski@linaro.org>, "Krzysztof
 Kozlowski" <krzk@kernel.org>, "Sylwester Nawrocki"
 <s.nawrocki@samsung.com>, "Chanwoo Choi" <cw00.choi@samsung.com>, "Alim
 Akhtar" <alim.akhtar@samsung.com>, "Michael Turquette"
 <mturquette@baylibre.com>, "Stephen Boyd" <sboyd@kernel.org>, "Sam
 Protsenko" <semen.protsenko@linaro.org>, "Peter Griffin"
 <peter.griffin@linaro.org>, =?utf-8?q?Andr=C3=A9_Draszik?=
 <andre.draszik@linaro.org>, "Tudor Ambarus" <tudor.ambarus@linaro.org>
Cc: <linux-samsung-soc@vger.kernel.org>, <linux-clk@vger.kernel.org>,
 <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>
X-Mailer: aerc 0.20.0
References: <20250305-clk-samsung-ref-init-data-v1-0-a4e03a019306@linaro.org> <20250305-clk-samsung-ref-init-data-v1-8-a4e03a019306@linaro.org>
In-Reply-To: <20250305-clk-samsung-ref-init-data-v1-8-a4e03a019306@linaro.org>

On Wed Mar 5, 2025 at 10:43 PM CET, Krzysztof Kozlowski wrote:
> Switch registering platform driver to platform_driver_probe(), so the
> 'struct platform_driver' can be properly discarded after init and there
> won't be need of __refdata to silence DEBUG_SECTION_MISMATCH.
>
> The change requires using subsys_initcall instead of core_initcall,
> because no device drivers would bound in the latter, as required by
> platform_driver_probe().
>
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Hi Krzysztof and apologies for the delay in testing.

On my Exynos990 platforms this patch causes similar oopses to those
sent by Andr=C3=A9 (different places each boot). I am unable to get the log=
s from
UART right now though (refactoring my testing setup). Apologies.

So this bug seems to be platformwide :(

Best regards,
Igor

