Return-Path: <linux-kernel+bounces-289401-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F3C189545D5
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 11:34:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A7B20286FB8
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 09:34:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 628801448E7;
	Fri, 16 Aug 2024 09:31:45 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 238FBBA33;
	Fri, 16 Aug 2024 09:31:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723800705; cv=none; b=lnNoLI/G/kAnfCyxYLYZFmH2CaCB2FPvOh+71xyNoIJS2sUotP7AAml/XZWGkMa+U8Qm024Y2/k6dK/HD83ctRu8ucpMVuXnMBTPoRTd8vLKWFOayH+j1ljR3SgO+vQsB8RriAIRGzqhrhWYR9K9KFQ5hiiNy4SucFQFXoH5fXg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723800705; c=relaxed/simple;
	bh=XXBo2JgIjPqkyzHVv+az8KK/5XX15hNV3l5qsdgu9Ek=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iTz6eNa9Sb5Co8KVaVxTDO6SGrXqeHBRN+myvWL2/Wz+87xcCpx4QjxqxUWPJel9fylpl2HISjw9w3uDTfaV2josDPQymnAqgcqqlfacYx25gjFGmUN52/XJCrdHRhofaZxZE7QsDm4f08du+pupy12OV6CKWiRZuQTqKiLSISo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3BCD2143D;
	Fri, 16 Aug 2024 02:32:08 -0700 (PDT)
Received: from usa.arm.com (e107155-lin.cambridge.arm.com [10.1.196.87])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 58C2A3F58B;
	Fri, 16 Aug 2024 02:31:41 -0700 (PDT)
From: Sudeep Holla <sudeep.holla@arm.com>
To: linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	arm-scmi@vger.kernel.org,
	Cristian Marussi <cristian.marussi@arm.com>
Cc: Sudeep Holla <sudeep.holla@arm.com>
Subject: Re: [PATCH] firmware: arm_scmi: Update various protocols versions
Date: Fri, 16 Aug 2024 10:31:37 +0100
Message-ID: <172380067263.785658.15995972469499735650.b4-ty@arm.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240812174027.3931160-1-cristian.marussi@arm.com>
References: <20240812174027.3931160-1-cristian.marussi@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Mon, 12 Aug 2024 18:40:27 +0100, Cristian Marussi wrote:
> A few protocol versions had been increased with SCMI v3.2.
> Update accordingly the supported version define in the kernel stack, since
> all the mandatory Base commands are indeed already supported.
> 
> 

Applied to sudeep.holla/linux (for-next/scmi/updates), thanks!

[1/1] firmware: arm_scmi: Update various protocols versions
      https://git.kernel.org/sudeep.holla/c/be9f086524b3
--
Regards,
Sudeep


