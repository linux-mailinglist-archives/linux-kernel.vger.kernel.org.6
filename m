Return-Path: <linux-kernel+bounces-543776-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E1DD4A4D9D2
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 11:09:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 160D718975C1
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 10:09:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79D7E1FDA78;
	Tue,  4 Mar 2025 10:08:58 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3576225D6;
	Tue,  4 Mar 2025 10:08:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741082938; cv=none; b=DXHoD4EG5WT7fXlMeNF5DSoaQGxNe24N1jWSuiAzxid7PV+NJd+PRUZfCIBF/ZH0Py5qt9z20Uk0yy9BgkeyYHKp7k8IiFP9zYBoAiLQvRC/1MP4lMU7b9KvRSBz3h99dNsRADbAq6gbEHLg22WZNfF3Jb0gZEsBRMa7KJtA/rw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741082938; c=relaxed/simple;
	bh=7pUDCtlrFILyQcyKs/tDPC50GkUzWmX1jAHf8k1hC/0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CCI9w1ZNgw8jUfmXWAq1TIqsqKTZfPXuF8scTMFYK14Z2kz4f1VTsnukz5xcywpva45qcFzs2uPfWKsMCTkfx3Khhcit3/DX5kY95P0CCAJYB5yioeXAeMnl1JMa7KIt7W8+m21MStHIPhMQfCAB23H1o5pmdR/v2gANCkDJajs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B1B2FFEC;
	Tue,  4 Mar 2025 02:09:09 -0800 (PST)
Received: from usa.arm.com (e133711.arm.com [10.1.196.55])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 305BF3F5A1;
	Tue,  4 Mar 2025 02:08:54 -0800 (PST)
From: Sudeep Holla <sudeep.holla@arm.com>
To: Hugues KAMBA MPIANA <hugues.kambampiana@arm.com>
Cc: Sudeep Holla <sudeep.holla@arm.com>,
	conor+dt@kernel.org,
	devicetree@vger.kernel.org,
	krzk+dt@kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	liviu.dudau@arm.com,
	lpieralisi@kernel.org,
	robh@kernel.org
Subject: Re: [PATCH v2] arm64: dts: corstone1000: Add definitions for secondary CPU cores
Date: Tue,  4 Mar 2025 10:08:47 +0000
Message-Id: <174108287362.420865.6246087705407586774.b4-ty@arm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250303170012.469576-1-hugues.kambampiana@arm.com>
References: <Z8XSIx75B4mtcV48@bogus> <20250303170012.469576-1-hugues.kambampiana@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Mon, 03 Mar 2025 17:00:12 +0000, Hugues KAMBA MPIANA wrote:
> Add `cpu1`, `cpu2` and `cpu3` nodes to the Corstone1000 device tree to
> enable support for secondary CPU cores.
>
> This update facilitates symmetric multiprocessing (SMP) support on
> the Corstone1000 Fixed Virtual Platform (FVP), allowing the
> secondary cores to be properly initialised and utilised.
>
> [...]

Applied to sudeep.holla/linux (for-next/juno/updates), thanks!

[1/1] arm64: dts: corstone1000: Add definitions for secondary CPU cores
      https://git.kernel.org/sudeep.holla/c/21b9f56cec8f
--
Regards,
Sudeep


