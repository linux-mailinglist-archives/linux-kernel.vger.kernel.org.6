Return-Path: <linux-kernel+bounces-174934-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D916A8C17A7
	for <lists+linux-kernel@lfdr.de>; Thu,  9 May 2024 22:35:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 929C32831B5
	for <lists+linux-kernel@lfdr.de>; Thu,  9 May 2024 20:35:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7E7579DD5;
	Thu,  9 May 2024 20:35:49 +0000 (UTC)
Received: from server.joladcareservices.co.uk (unknown [162.214.0.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96BCA376
	for <linux-kernel@vger.kernel.org>; Thu,  9 May 2024 20:35:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.214.0.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715286949; cv=none; b=DvGYwEAz5E3GU28yfSEqSaRA370EoX2Uw+6ld9Y99WzBYfRYfACVEETio0nzXhha4EFKNNQcWYSxVdGBcFUMUIwlxybp25GsPiXGRxmJoj7ocI12fbrua6XOqKA84wtkwFNBFP61PaPsByyejhWsjgGpiiN8IlbwA8fMy3ZGZ1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715286949; c=relaxed/simple;
	bh=zx83MejzDDttGLLYlxoEwoFl+NiFfOGqKcUjZEjjEI0=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Udy18jl2ISXxtPJmnOEmIT5TahOLM/S2Cel7tlTeIHZLYAfO8Rj+ZkEQITZme08lcwJd+JjmRzFwOrBzrLdYkjloUnB93fpuHnVYG/YU2xZ3fmvC3AxkxKlCOd9fm9Lz8NwcuTpMgVf+dcbqzEm3suqzhP4erCDUUDtqbrd8jcM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=houseofdisruption.com; spf=none smtp.mailfrom=houseofdisruption.com; arc=none smtp.client-ip=162.214.0.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=houseofdisruption.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=houseofdisruption.com
Received: from [104.223.100.74] (port=65453 helo=houseofdisruption.com)
	by server.joladcareservices.co.uk with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96.2)
	(envelope-from <akorede@houseofdisruption.com>)
	id 1s55m8-0004nW-1a
	for linux-kernel@vger.kernel.org;
	Thu, 09 May 2024 09:33:39 -0600
Reply-To: vendorscontractor@servicesetihadaviationgroup.com
From: Etihad Aviation Group PJSC<akorede@houseofdisruption.com>
To: linux-kernel@vger.kernel.org
Subject: Etihad Aviation Group, UAE 2024/2025 projects
Date: 9 May 2024 08:33:33 -0700
Message-ID: <20240509083151.5EE69DA45E392683@houseofdisruption.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - server.joladcareservices.co.uk
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - houseofdisruption.com
X-Get-Message-Sender-Via: server.joladcareservices.co.uk: authenticated_id: akorede@houseofdisruption.com
X-Authenticated-Sender: server.joladcareservices.co.uk: akorede@houseofdisruption.com
X-Source: 
X-Source-Args: 
X-Source-Dir: 



Attn: Sir/Madam,

Greetings from  Etihad Aviation Group, UAE.

We are inviting your esteemed company for Vendor/Contractor=20
Partnership registration with Etihad Aviation Group, UAE=20
2024/2025 projects.

These projects are open for all companies around the world. If=20
you have intention to participate in the process, please confirm=20
your interest by asking for Vendor Questionnaire and EOI.

Your prompt response would be greatly appreciated as it will help=20
us expedite the vendor/contractor selection process.

Looking forward to your reply.

Kind Regards,

Mr.George Ibrahim
Contractors Coordinator
Group Procurement & Contracts Shared Services Center
Etihad Aviation Group PJSC
Etihad Airways - Head office, New Airport Road,
Khalifa City, PO Box 35566, Abu Dhabi
United Arab Emirates.

