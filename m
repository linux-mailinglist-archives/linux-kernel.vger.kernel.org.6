Return-Path: <linux-kernel+bounces-189170-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C0118CEC61
	for <lists+linux-kernel@lfdr.de>; Sat, 25 May 2024 00:21:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EA56A2828D2
	for <lists+linux-kernel@lfdr.de>; Fri, 24 May 2024 22:21:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CD188595B;
	Fri, 24 May 2024 22:21:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b2TkXcnq"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A88BB1DFFC;
	Fri, 24 May 2024 22:21:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716589298; cv=none; b=aWF+VTDlrxFkD9pZeW7sX7T3fJnnyNb/AOaxndS0eif5qst+E0j0DPNPPmAWcD7HbblLtZ1vqLLAuICOJ9fwjcRaorx3t+EMlySP0qwtsDSBr13PCNeyIUjb1ChP2OewfOfW1bE7P3bEmZGDps3iJU4XynoYDOxm3pQcxhn7160=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716589298; c=relaxed/simple;
	bh=EeJzb3mSGJq4pUEyp8uUcM94K108LeBzS6OPf3wdF6I=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=M3BwyDy87TUPXs07nSzeVuNv7wojXxFOZ2FW4zIY3UKsyExPVWaWhc8Z4kqdZiP23ODFPb9jsA/Oni1qbjHTWqX/MTmZgWREoJGTTpStAL3UJy33OTM1y0MDSs37heYtRCe8T4yUxE689yaWZuwszQtBd2V4by76KF5/2uGRdfE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b2TkXcnq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B9E5EC2BBFC;
	Fri, 24 May 2024 22:21:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716589298;
	bh=EeJzb3mSGJq4pUEyp8uUcM94K108LeBzS6OPf3wdF6I=;
	h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
	b=b2TkXcnqcchNXExNJ0Hlf7RamZiP5mcjT7d1YDZOb4QcuRDfsT3A6CNPdY1QpmJl0
	 Wtm1a2Otd3a/Smc41e/9QYqRvor9eK9EYAJvVL1SHlrpkwcdwuCdBqdzYS8N/KG1tG
	 fly6ZHZT2VwuAdLn9IKAl8pX0x1tDi1Dug/FMmifWfcdS83EBDkwsKEih57NRK0kNH
	 AFds20tADVkaQ+xMiz5cIWVwT/cm7PKlb/RyZFo7h/UtpufrEKPzspJkSVv1nzpi6h
	 nSDOX/zcUauciiU8tQKpBXg8bkAtHqjf6GYv2bhUaZsBiq7wUV2xxlobb+z6XZ3dWW
	 g+VF5dmGlGVYw==
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sat, 25 May 2024 01:21:34 +0300
Message-Id: <D1I84BEOGWMW.25XO15A34Y8J2@kernel.org>
Cc: "kernel test robot" <lkp@intel.com>, "david" <david@sigma-star.at>,
 "oe-kbuild-all" <oe-kbuild-all@lists.linux.dev>, "linux-kernel"
 <linux-kernel@vger.kernel.org>, "david oberhollenzer"
 <david.oberhollenzer@sigma-star.at>
Subject: Re: security/keys/trusted-keys/trusted_dcp.c:206:24: sparse:
 sparse: incorrect type in assignment (different base types)
From: "Jarkko Sakkinen" <jarkko@kernel.org>
To: "Richard Weinberger" <richard@nod.at>
X-Mailer: aerc 0.17.0
References: <202405240610.fj53EK0q-lkp@intel.com>
 <1855855000.144805.1716584815663.JavaMail.zimbra@nod.at>
 <D1I6WMDSLOW0.2RS18E7T61X9A@kernel.org>
 <39518719.144820.1716586062550.JavaMail.zimbra@nod.at>
In-Reply-To: <39518719.144820.1716586062550.JavaMail.zimbra@nod.at>

On Sat May 25, 2024 at 12:27 AM EEST, Richard Weinberger wrote:
> > Please send then fix, reasoning of that, and finally:
> Sure. Let me first talk to David and give it a test...

No rush

BR, Jarkko

