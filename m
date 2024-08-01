Return-Path: <linux-kernel+bounces-270589-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AF619441C6
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 05:22:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D0A4B28410D
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 03:22:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDA7214AD23;
	Thu,  1 Aug 2024 03:20:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Dh7t1DnS"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FC5014A600;
	Thu,  1 Aug 2024 03:20:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722482406; cv=none; b=BCj9zF57yD6JR1qQ2USodcPyTbUSf/3+iKLq4CfzjBBg0h7eEg/kHKxcb2qU6KjSJzR05by15RYyJ5dNVZaAhclvsnf6L7ZcbRW7kVKTbmu5HSnZs+sV5YhncI8slThzD1qkFJky33PBLGt5s5poj9FVxijbDlxhIU7Cor71OL8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722482406; c=relaxed/simple;
	bh=rLUjBEvMax6m2utxb/++8xf71UtwXVnjbOIIQiIN6/U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EDMTXDrMT5vqgHiajh/iymSxhGwx+sF4O79ZfRaJfldrRzChW1pWbhzyp+rQthvf8YiKYhj8GYWn4HzKj10XIWSjhIuTd5uN4i5EXAYCU3U82mZeiFOkEAlYJJ4zz45BUOKfvAQjGWCX0J8dY30Kk173TTrwY2WHfM9AE/w8hks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Dh7t1DnS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94A11C4AF12;
	Thu,  1 Aug 2024 03:20:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722482405;
	bh=rLUjBEvMax6m2utxb/++8xf71UtwXVnjbOIIQiIN6/U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Dh7t1DnS50Kqt/2amN+2xosOEchT1E+9tWxZxWZTzIS99coNl+BL2UQ/r9uxRl1ji
	 o4ZOrA3Y6zSK2sT+eReCa80ybhoIHnBULxgInqoKGWRgaIMp3JLsmIAEmMaSRmL04r
	 VlHo+lkqWmmeQdqkTN+L3JcEWLwo0ds8d9Yiv1EptPZx0Ak6+3bbKyL3ygKFjAzqLu
	 hlDmisU7jn5pjLam7RwmjdHId+ohDH7SSgtJ8KBLTk7cHTaW7jJGs8Fmw0xBWJNURy
	 /CrXB/MPbSJtEn5y2r28k6NT1JQ1OeEDoIfbsdy8Hko1RN/NTfHuylXuW57NtZTNAX
	 znZj/gEwSw+uQ==
From: Bjorn Andersson <andersson@kernel.org>
To: agross@kernel.org,
	robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org,
	richardcochran@gmail.com,
	Konrad Dybcio <konradybcio@kernel.org>,
	Ankit Sharma <quic_anshar@quicinc.com>
Cc: linux-arm-msm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org
Subject: Re: [PATCH V1] arm64: dts: qcom: sa8775p: Add capacity and DPC properties
Date: Wed, 31 Jul 2024 22:19:47 -0500
Message-ID: <172248238600.319692.2947279740029817295.b4-ty@kernel.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240731111951.6999-1-quic_anshar@quicinc.com>
References: <20240731111951.6999-1-quic_anshar@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Wed, 31 Jul 2024 16:49:51 +0530, Ankit Sharma wrote:
> The "capacity-dmips-mhz" and "dynamic-power-coefficient" are
> used to build Energy Model which in turn is used by EAS to take
> placement decisions.
> 
> 

Applied, thanks!

[1/1] arm64: dts: qcom: sa8775p: Add capacity and DPC properties
      commit: 717ca334afd7ceb8170aa1bdad736f6a712c9220

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>

