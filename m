Return-Path: <linux-kernel+bounces-394200-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E7CF9BABC1
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 05:15:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DD30F281979
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 04:15:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F99A192B91;
	Mon,  4 Nov 2024 04:13:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YR8RoZW1"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0E3818E37D;
	Mon,  4 Nov 2024 04:13:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730693636; cv=none; b=GJ2kVZd3IUFAAW/XfSMqKU0O7n+frkVwBAmh6hg9bmdmNr+XPjft8lSjeq1UaMtbleKVCWSxhl/3yPVGRtCItf3d/9LNAafuojBG8vWc1RAbtcLZgFVxrlj/HGUgiTKRfNTPqIuoHNYuY29lC8mUMu1DOtMLz5c7HxJzFvObyTk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730693636; c=relaxed/simple;
	bh=3bhpqJLpFskArMW0nCOqg6POEfvKfl3dMRL/dC9SyT0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dzP3BEHCGJt/XkEFq10doLqHo/dtvC2knmdouUblth3QsiahauhnPTKZozW4RPsrJJXfxIoTh1F/ygiTyAvFtza/XUDPmfub4lMdRXEPwnry/kc8h3mLVHWL5AeGF8VMcyh9gqcDqX5ea/kQGEHK6F5RhoSbUryXCOvfN6phgNQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YR8RoZW1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01340C4CED6;
	Mon,  4 Nov 2024 04:13:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730693635;
	bh=3bhpqJLpFskArMW0nCOqg6POEfvKfl3dMRL/dC9SyT0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=YR8RoZW1MR5lua7q0pXjFYLHjQc65PxU4TOB1YUYMBnCI5yYOsJuz7UyVtLMYDv/A
	 sH2VTaOmzgD/unEjvOOk0h4WcSoL995eD6mJRH+ciAveIsbQxOoo6ujH58HzOSF6uC
	 JeOXwSd9pBjobHx1MoeyS/blyNi1i7EJSs3kG5wE3orqp7ZTe47iswXXvH+soDSS/Q
	 qBL4kczgkkzL3xAsCcgaOZQ3mP53kQi6yULMgUVXsFrIEM+jUj5KwFSwPq9jZgikT5
	 NDykeHganeAoRt7b3qhakGX0nWM4cDge+VtLWM4FguDIRPZY37OFzbPtA8YQ0+C0tu
	 WxK98XllWgIig==
From: Bjorn Andersson <andersson@kernel.org>
To: Konrad Dybcio <konradybcio@kernel.org>,
	Johan Hovold <johan+linaro@kernel.org>
Cc: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Abel Vesa <abel.vesa@linaro.org>,
	Stephan Gerhold <stephan.gerhold@linaro.org>,
	linux-arm-msm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] arm64: dts: x1e80100-crd: describe HID supplies
Date: Sun,  3 Nov 2024 22:13:42 -0600
Message-ID: <173069362369.23540.17529214305304554724.b4-ty@kernel.org>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241029075258.19642-1-johan+linaro@kernel.org>
References: <20241029075258.19642-1-johan+linaro@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Tue, 29 Oct 2024 08:52:58 +0100, Johan Hovold wrote:
> Add the missing HID supplies to avoid relying on other consumers to keep
> them on.
> 
> This also avoids the following warnings on boot:
> 
> 	i2c_hid_of 0-0010: supply vdd not found, using dummy regulator
> 	i2c_hid_of 0-0010: supply vddl not found, using dummy regulator
> 	i2c_hid_of 1-0015: supply vdd not found, using dummy regulator
> 	i2c_hid_of 1-0015: supply vddl not found, using dummy regulator
> 	i2c_hid_of 1-003a: supply vdd not found, using dummy regulator
> 	i2c_hid_of 1-003a: supply vddl not found, using dummy regulator
> 
> [...]

Applied, thanks!

[1/1] arm64: dts: x1e80100-crd: describe HID supplies
      commit: 266cb58f08f3ca4674ef976166b49c3a60b60463

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>

