Return-Path: <linux-kernel+bounces-406292-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 451EB9C5D90
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 17:42:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8C842B43F11
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 16:13:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 796682038C4;
	Tue, 12 Nov 2024 16:10:24 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AAC62038B3;
	Tue, 12 Nov 2024 16:10:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731427824; cv=none; b=t4inEuV50jV9oVEzQAVM2IadsWMD/6l0i+h/oFGWX9LjdEDXOWyCzWmgilQPOA+okbSjkg6BCaivl40eNPWbONZv4ytomMq8k8QfK0mw39unyAjlGf0GUdLWH9SMVB7CwDVL2G+8IEPMUSz/7IKzIjxdNccyI0X1ZiSYGm7CeVo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731427824; c=relaxed/simple;
	bh=4nkBZXA7nWQGrxxFZta58A8GgOShPCiUUa7twZb4630=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pxUA2qJxDzqGwAR0+NdSGyE4fJoMglY5MTqFYP/Mo4AEEmy5bDrzBdIwgokwXss3NtV69+ydQZNpvW8Sh/NfBpkbALy1CfxJ8BefQWWv5PGSsgsZ19krm3N9a/OvMLt1DxyXualoRHIcLL1aJW0amWHjtsG4VOM8UBHcP6jAbzU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8D9EC4CECD;
	Tue, 12 Nov 2024 16:10:21 +0000 (UTC)
From: Catalin Marinas <catalin.marinas@arm.com>
To: Will Deacon <will@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Oleg Nesterov <oleg@redhat.com>,
	Mark Brown <broonie@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64/ptrace: Clarify documentation of VL configuration via ptrace
Date: Tue, 12 Nov 2024 16:10:19 +0000
Message-Id: <173142780465.896456.9873316347312765271.b4-ty@arm.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241106-arm64-sve-ptrace-vl-set-v1-1-3b164e8b559c@kernel.org>
References: <20241106-arm64-sve-ptrace-vl-set-v1-1-3b164e8b559c@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Wed, 06 Nov 2024 17:41:32 +0000, Mark Brown wrote:
> When we configure SVE, SSVE or ZA via ptrace we allow the user to configure
> the vector length and specify any of the flags that are accepted when
> configuring via prctl(). This includes the S[VM]E_SET_VL_ONEXEC flag which
> defers the configuration of the VL until an exec(). We don't do anything to
> limit the provision of register data as part of configuring the _ONEXEC VL
> but as a function of the VL enumeration support we do this will be
> interpreted using the vector length currently configured for the process.
> 
> [...]

Applied to arm64 (for-next/misc), thanks!

[1/1] arm64/ptrace: Clarify documentation of VL configuration via ptrace
      https://git.kernel.org/arm64/c/c0139f6cbb1f

-- 
Catalin


