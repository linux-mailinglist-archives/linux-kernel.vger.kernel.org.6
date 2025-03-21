Return-Path: <linux-kernel+bounces-570719-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 16691A6B3DE
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 05:59:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6BAB046091E
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 04:59:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E5361E8854;
	Fri, 21 Mar 2025 04:59:14 +0000 (UTC)
Received: from mx10.didiglobal.com (mx10.didiglobal.com [111.202.70.125])
	by smtp.subspace.kernel.org (Postfix) with SMTP id 42D0D2AD0C;
	Fri, 21 Mar 2025 04:59:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=111.202.70.125
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742533154; cv=none; b=HfV/0sPZMIUaUYjTIbVFjh4uAYAOvcXyvLvOzEoX1S9OWa15Ef1MWHL8Gmxaub9ZdpLbBedryoPgbrDLHKBDmnMLNik3B7L0jXojykz3INGs6srUNm+NU0hPWQPDfKzJsM2vKoThWtrNeTtA35U9Ysd5xoMQ6TDB5BNpFTSdcko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742533154; c=relaxed/simple;
	bh=zMlId87PmGZyTfZEumeSCJxmQE1Rd6IAxiRdzITwbkQ=;
	h=Date:From:To:CC:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=IR7e0joqFULX5wSBB7oFqr20Gbyj6/cQnAH6MmJQm1JqYPkbeNJ8CzFw9wknEDp4t0+4Rf4p6M7r5pLoYwaNv7uFzyu5TygdHk2daWt0mNkevQU53wTACSZWoAkHWEKjAGknRUv3gvqjlq80Nrqf6jb8TvlPTcV6l4fywje0Ihw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=didiglobal.com; spf=pass smtp.mailfrom=didiglobal.com; arc=none smtp.client-ip=111.202.70.125
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=didiglobal.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=didiglobal.com
Received: from mail.didiglobal.com (unknown [10.79.71.38])
	by mx10.didiglobal.com (MailData Gateway V2.8.8) with ESMTPS id 478FF180DA8B56;
	Fri, 21 Mar 2025 12:55:04 +0800 (CST)
Received: from BJ03-ACTMBX-07.didichuxing.com (10.79.71.34) by
 BJ03-ACTMBX-02.didichuxing.com (10.79.71.38) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Fri, 21 Mar 2025 12:55:33 +0800
Received: from OneApple (10.79.64.102) by BJ03-ACTMBX-07.didichuxing.com
 (10.79.71.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.1544.11; Fri, 21 Mar
 2025 12:55:33 +0800
Date: Fri, 21 Mar 2025 12:55:32 +0800
X-MD-Sfrom: chentaotao@didiglobal.com
X-MD-SrcIP: 10.79.71.38
From: Taotao chen <chentaotao@didiglobal.com>
To: <a.hindborg@kernel.org>
CC: <bjorn3_gh@protonmail.com>, <boqun.feng@gmail.com>, <chentao325@qq.com>,
	<linux-kernel@vger.kernel.org>, <rust-for-linux@vger.kernel.org>
Subject: Re: [PATCH] rust: block: Remove unnecessary comma in introduction
Message-ID: <Z9zxRAikHareSeM2@OneApple>
Mail-Followup-To: a.hindborg@kernel.org, bjorn3_gh@protonmail.com,
	boqun.feng@gmail.com, chentao325@qq.com,
	linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <8734f9i8na.fsf@kernel.org>
X-ClientProxiedBy: BJ01-PUBMBX-01.didichuxing.com (10.79.64.22) To
 BJ03-ACTMBX-07.didichuxing.com (10.79.71.34)

Hi, Andreas

I realized that my previous commit message was incorrect — the comma
removed was before "methods" not after. I will submit a v2 patch to
correct this.

Apologies for the mistake, and thank you for your time.

Best regards,
Chentaotao

