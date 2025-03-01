Return-Path: <linux-kernel+bounces-539945-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B119A4AB2E
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Mar 2025 14:23:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 515331641C3
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Mar 2025 13:23:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECBEB1DEFF3;
	Sat,  1 Mar 2025 13:23:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zohomail.com header.i=safinaskar@zohomail.com header.b="fBPIVP7j"
Received: from sender4-pp-o94.zoho.com (sender4-pp-o94.zoho.com [136.143.188.94])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4C4B23F36F;
	Sat,  1 Mar 2025 13:23:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.94
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740835385; cv=pass; b=vCvvsx6af7xb6M9wll8oFSISXgNOmCVu+9+KgQF3aVXtdWGj7O05DDcJp5Ydtyb27N71dRIJu94SWL169oY0FWhmZ18P1i2Zg9HveVIYjWaR2n8WfFGtXqpFz8P6mwdB1zp+vtH1PdYBM5gEtmuvi7zAFICUP0v0S/fIU8BKWkM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740835385; c=relaxed/simple;
	bh=kmbLST3B8l0hqe9GENyoXR0gvr550yOwf3BicKoSaRI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=anp3L7Ijw6kF2h4sZPYwWNzJAUsH5KMw+Lq7ECrMDtBk0sxYNr0NzYikANgFGCUkMo6CDB4MX4qTVA8vudxa8SQg/8pXGJfa6382PFXJAXZkbjZrtMovLVg4JtQtvx4AQVRjPBvADb1eTeM7+GYhrRXvs8E/pK7lF/4+qqBHXVs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com; spf=pass smtp.mailfrom=zohomail.com; dkim=pass (1024-bit key) header.d=zohomail.com header.i=safinaskar@zohomail.com header.b=fBPIVP7j; arc=pass smtp.client-ip=136.143.188.94
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zohomail.com
ARC-Seal: i=1; a=rsa-sha256; t=1740835359; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=DyGYgAA9r+gh65F1jDw/kd6i10I6ZI7zLXjXapQeoL3h2qCEuW08+I10ZETBUG0p4F8U5u1u6bkzpBU9+m9xGuHmC/sxT1pUiwmMTD6UeHwMTeXnavKeNf7IYiBi8kusqI8dGqh36HXueuOAuPHJ5FEHTjDWkA4UnURGGLXXyK8=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1740835359; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=QEcFFAxfF3kvhNHl30onzxCesolmRPddXa5t/GhIDeo=; 
	b=i1wCLMoaEflVnz3aN4XCVSqvkJzLBDVY2MDQeD8B70YoV5lwF1PvHgaea/pS3mpTYa9bHa1RgvxrVn5e/UBs2SZezhE+vYkTBDaSmp7Sr2sNGmcDLdieC4rErUQDXiHF/NVDqdOrzF9Ry2oRmhUNSN7BSBG72j50crtE16qlfAg=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=zohomail.com;
	spf=pass  smtp.mailfrom=safinaskar@zohomail.com;
	dmarc=pass header.from=<safinaskar@zohomail.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1740835359;
	s=zm2022; d=zohomail.com; i=safinaskar@zohomail.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-Id:Message-Id:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Feedback-ID:Reply-To;
	bh=QEcFFAxfF3kvhNHl30onzxCesolmRPddXa5t/GhIDeo=;
	b=fBPIVP7jnUtgIL+9m++gSejGk+MW12beyjlgMRsnsY+dE/eyLKiCMI/BXbJt1HtT
	WaPZxey19meiC7oFRvD8klz0sZHU1z8X70GpPG9yIINJKfNuy0iFQyScjbmMkJaksUP
	yaju1DluJoGPZenbFJLWUhS4Xy0zdxOjVrT+oLCE=
Received: by mx.zohomail.com with SMTPS id 1740835355747738.2807174501816;
	Sat, 1 Mar 2025 05:22:35 -0800 (PST)
From: Askar Safin <safinaskar@zohomail.com>
To: uecker@tugraz.at,
	dan.carpenter@linaro.org
Cc: airlied@gmail.com,
	boqun.feng@gmail.com,
	gregkh@linuxfoundation.org,
	hch@infradead.org,
	hpa@zytor.com,
	ksummit@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	miguel.ojeda.sandonis@gmail.com,
	rust-for-linux@vger.kernel.org,
	torvalds@linux-foundation.org
Subject: Re: Rust kernel policy
Date: Sat,  1 Mar 2025 16:22:29 +0300
Message-Id: <20250301132229.3115698-1-safinaskar@zohomail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <61a7e7db786d9549cbe201b153647689cbe12d75.camel@tugraz.at>
References: <61a7e7db786d9549cbe201b153647689cbe12d75.camel@tugraz.at>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Feedback-ID: rr08011227d3f563c35efbb5d496057d920000f1ec4ce021640ea1b87657279fa549649710fe5cfa1eb332eb:zu080112270ea6dcf8350928bbb567b6af00005e2f2d536712854d902d7af778adf91d6c3919efd38df7dd98:rf0801122ccb5ccc2d4433bfc49c9c7ce20000c2e34ae1f49168ead396ae91ea6985b023a27386bb9cf2fbf0babb6c5a34:ZohoMail
X-ZohoMailClient: External

Hi, Martin Uecker and Dan Carpenter.

> No, this absolutely is useful.  This is what UBSan does now

> BTW: Another option I am investigating it to have UBsan insert traps
> into the code and then have the compiler emit a warning only when

Clang sanitizers should not be enabled in production.
See https://www.openwall.com/lists/oss-security/2016/02/17/9 for details

